import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'willow_sensor_characteristic.dart';
import 'willow_sensor_measurement.dart';

class WillowSensorConsts {
  /* Sent by sensor to indicate it has received an unexpected
   * chunk from the controller. */
  static const int dfuNack = 1 << 31;

  /* Sent by controller to indicate the current chunk is the last
   * one in the image. */
  static const int dfuFinal = 1 << 31;
}

class WillowEventFlags {
  // Running from an unconfirmed image. Resolve by confirming the running image.
  static const int unconfirmedImage = 1 << 0;

  // Sensor has no timesync, or it needs to be re-synced to limit drifting.
  static const int needTimesync = 1 << 1;

  // Sensor was reset due to a brownout. Resolve by clearing flags.
  static const int brownoutReset = 1 << 2;

  // Sensor was reset due to a cpu lockup. Resolve by clearing flags.
  static const int cpuLockupReset = 1 << 3;

  // Sensor was reset due to watchdog. Resolve by clearing flags.
  static const int wdtReset = 1 << 4;
}

class WillowSensorDfuState {
  final int offset;

  WillowSensorDfuState(this.offset);
}

class WillowSensorFwVersion {
  WillowSensorFwVersion(this.major, this.minor, this.patch, this.hw);

  final int major;
  final int minor;
  final int patch;
  final int hw;
}

class WillowSensorMfgData {
  WillowSensorMfgData(Uint8List data) {
    final bytes = ByteData.sublistView(data);
    final flags = bytes.getUint16(0, Endian.little);

    /* Bit 15 = pairing open flag */
    pairingOpen = flags & (1 << 15) != 0;
    /* Bit 14 = event flag */
    event = flags & (1 << 14) != 0;
    /* Bit 13 is reserved for future use */
    /* Bits 0..12 = version number */
    version = flags & ((1 << 13) - 1);
  }

  late bool event;
  late bool pairingOpen;
  late int version;
}

class WillowSensorCtrlProc {
  static const seek = 0x01;
  static const timesync = 0x02;
  static const dfuErase = 0x03;
  static const dfuUpgrade = 0x04;
  static const dfuConfirm = 0x05;
  static const eventsRead = 0x06;
  static const eventsClear = 0x07;
  static const fwVersion = 0x08;
  static const dfuState = 0x09;
}

class WillowSensorInteractor {
  WillowSensorInteractor({required FlutterReactiveBle ble}) : _ble = ble;

  final FlutterReactiveBle _ble;

  Future<Uint8List> _ctrlRequest(String deviceId, List<int> req) async {
    final ctrl = WillowSensorCharacteristic.ctrl(deviceId);
    final response = _ble.subscribeToCharacteristic(ctrl).first;

    await _ble.writeCharacteristicWithResponse(ctrl, value: req);
    final responseData = Uint8List.fromList(await response);

    if (responseData.length < 3) {
      throw Exception("Unexpected response length");
    }

    if (responseData[0] != 0x70) {
      throw Exception("Unexpected value in response");
    }

    if (responseData[1] != req[0]) {
      throw Exception("Response proc does not match request");
    }

    if (responseData[2] != 0x00) {
      throw Exception("Response indicated error");
    }

    return responseData;
  }

  Future<void> ctrlSeek(String deviceId, int lastTimestamp) async {
    final req = ByteData(5);

    req.setUint8(0, WillowSensorCtrlProc.seek);
    req.setUint32(1, lastTimestamp, Endian.little);

    _ctrlRequest(deviceId, req.buffer.asUint8List());
  }

  Future<void> _ctrlTimesync(String deviceId, int timestamp) async {
    final req = ByteData(5);

    req.setUint8(0, WillowSensorCtrlProc.timesync);
    req.setUint32(1, timestamp, Endian.little);

    await _ctrlRequest(deviceId, req.buffer.asUint8List());
  }

  Future<void> eraseImage(String deviceId) async =>
      await _ctrlRequest(deviceId, [WillowSensorCtrlProc.dfuErase]);

  Future<void> confirmRunningImage(String deviceId) async =>
      await _ctrlRequest(deviceId, [WillowSensorCtrlProc.dfuConfirm]);

  Future<void> upgrade(String deviceId) async =>
      await _ctrlRequest(deviceId, [WillowSensorCtrlProc.dfuUpgrade]);

  Future<WillowSensorDfuState> readDfuState(String deviceId) async {
    final data = await _ctrlRequest(deviceId, [WillowSensorCtrlProc.dfuState]);
    final payload = ByteData.sublistView(data, 3);
    return WillowSensorDfuState(payload.getUint32(0, Endian.little));
  }

  Future<int> readEventFlags(String deviceId) async {
    final data =
        await _ctrlRequest(deviceId, [WillowSensorCtrlProc.eventsRead]);
    final payload = ByteData.sublistView(data, 3);
    return payload.getUint32(0, Endian.little);
  }

  Future<void> clearEventFlags(String deviceId, int mask) async {
    final req = ByteData(5);

    req.setUint8(0, WillowSensorCtrlProc.eventsClear);
    req.setUint32(1, mask, Endian.little);

    await _ctrlRequest(deviceId, req.buffer.asUint8List());
  }

  Future<WillowSensorFwVersion> getFwVersion(String deviceId) async {
    final data = await _ctrlRequest(deviceId, [WillowSensorCtrlProc.dfuState]);
    final ver = data.sublist(3);

    return WillowSensorFwVersion(ver[0], ver[1], ver[2], ver[3]);
  }

  Future<void> setTime(String deviceId, DateTime time) async {
    return _ctrlTimesync(deviceId, time.millisecondsSinceEpoch ~/ 1000);
  }

  Future<List<int>> _measRead(String deviceId) async {
    return await _ble
        .readCharacteristic(WillowSensorCharacteristic.meas(deviceId));
  }

  Future<List<int>> readMeasurements(String deviceId, int lastTimestamp) async {
    final List<int> measurements = [];
    while (true) {
      await ctrlSeek(deviceId, lastTimestamp);
      var chunk = await _measRead(deviceId);
      if (chunk.isEmpty) {
        return measurements;
      }
      measurements.addAll(chunk);
      lastTimestamp = getLatestTimeStamp(measurements);
    }
  }

  Stream<int> _subscribeToNackEvents(
          QualifiedCharacteristic dfuCharacteristic) =>
      _ble
          .subscribeToCharacteristic(dfuCharacteristic)
          .map((data) => ByteData.sublistView(Uint8List.fromList(data))
              .getUint32(0, Endian.little))
          .where((event) => (event & WillowSensorConsts.dfuNack) != 0)
          .map((event) => (event & ~WillowSensorConsts.dfuNack));

  Future<void> writeFirmware(
      {required String deviceId, required Uint8List fwImage}) async {
    final dfu = WillowSensorCharacteristic.dfu(deviceId);
    final nackEvents = _subscribeToNackEvents(dfu);
    final mtu = await _ble.requestMtu(deviceId: deviceId, mtu: 247);
    final buffer = ByteData(mtu);
    var offset = 0;

    while (offset < fwImage.length) {
      final chunkSize = min(mtu - 4, fwImage.length - offset);

      if (offset + chunkSize < fwImage.length) {
        buffer.setUint32(0, offset, Endian.little);
      } else {
        buffer.setUint32(
            0, offset | WillowSensorConsts.dfuFinal, Endian.little);
      }

      buffer.buffer.asUint8List(4).setRange(0, chunkSize, fwImage, offset);

      await _ble.writeCharacteristicWithoutResponse(dfu,
          value: buffer.buffer.asUint8List(0, chunkSize + 4));

      offset = await nackEvents.first.timeout(
        const Duration(milliseconds: 20),
        onTimeout: () => offset + chunkSize,
      );
    }
  }
}

int getLatestTimeStamp(List<int> measurements) {
  final bytes = Uint8List.fromList(measurements);
  const measSize = 13;
  final numMeas = bytes.length ~/ measSize;
  final List<int> timeStamps = [];
  for (int i = 0; i < numMeas; i++) {
    final measBytes =
        ByteData.sublistView(bytes, i * measSize, (i + 1) * measSize);
    final timeStamp = measBytes.getUint32(0, Endian.little);
    timeStamps.add(timeStamp);
  }
  return timeStamps.last;
}
