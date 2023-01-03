import 'dart:convert';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'willow_hub_characteristic.dart';

class WillowHubInteractor {
  final FlutterReactiveBle _ble;

  WillowHubInteractor(FlutterReactiveBle ble) : _ble = ble;

  Future<String> getVersion(String deviceId) {
    return writeReadString(WillowHubCharacteristic.protoVer(deviceId), "---");
  }

  Future<List<int>> writeRead(
      QualifiedCharacteristic characteristic, List<int> msg) async {
    await _ble.writeCharacteristicWithResponse(characteristic, value: msg);
    return await _ble.readCharacteristic(characteristic);
  }

  Future<List<int>> writeReadNoResp(
      QualifiedCharacteristic characteristic, List<int> msg) async {
    await _ble.writeCharacteristicWithoutResponse(characteristic, value: msg);
    return await _ble.readCharacteristic(characteristic);
  }

  Future<String> writeReadString(
      QualifiedCharacteristic characteristic, String data) async {
    const latin1 = Latin1Codec();
    return latin1.decode(await writeRead(characteristic, latin1.encode(data)));
  }
}
