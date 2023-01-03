import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'willow_service.dart';

class WillowBLEScanner {
  WillowBLEScanner(FlutterReactiveBle ble) : _ble = ble;

  final FlutterReactiveBle _ble;

  /// checks if discovered device is sensor
  /// if false, then device is willow hub
  bool isSensor(DiscoveredDevice discoveredDevice) {
    return discoveredDevice.serviceUuids
        .contains(WillowService.sensorServiceUuid);
  }

  /// scan for both willow sensor and hub
  /// scan should be stopped by  cancelling subscription
  Stream<DiscoveredDevice> scanAllWillowDevices() async* {
    yield* _ble.scanForDevices(withServices: [
      WillowService.hubServiceUuid,
      WillowService.sensorServiceUuid
    ]);
  }

  /// scan for willow sensor
  /// scan should be stopped by  cancelling subscription
  Stream<DiscoveredDevice> scanWillowSensors() async* {
    yield* _ble.scanForDevices(withServices: [WillowService.sensorServiceUuid]);
  }

  /// scan for willow  hub
  /// scan should be stopped by  cancelling subscription
  Stream<DiscoveredDevice> scanWillowHub() async* {
    yield* _ble.scanForDevices(withServices: [WillowService.hubServiceUuid]);
  }
}
