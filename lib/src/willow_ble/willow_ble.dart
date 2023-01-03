import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'hub/willow_hub_interactor.dart';
import 'sensor/willow_sensor_interactor.dart';
import 'willow_ble_connection_manager.dart';
import 'willow_ble_scanner.dart';

class WillowBle {
  static final WillowBle instance = WillowBle._internal();

  factory WillowBle() => instance;

  WillowBle._internal();

  late WillowHubInteractor hubInteractor;
  late WillowSensorInteractor sensorInteractor;
  late WillowBLEScanner willowBLEScanner;
  late WillowBleConnectionManager willowBleConnectionManager;

  late Stream<BleStatus> statusStream;

  /// init function initializes hub and sensor interactor
  void init() {
    final FlutterReactiveBle ble = FlutterReactiveBle();
    hubInteractor = WillowHubInteractor(ble);
    sensorInteractor = WillowSensorInteractor(ble: ble);
    willowBLEScanner = WillowBLEScanner(ble);
    willowBleConnectionManager = WillowBleConnectionManager(ble);
    statusStream = ble.statusStream;
  }
}
