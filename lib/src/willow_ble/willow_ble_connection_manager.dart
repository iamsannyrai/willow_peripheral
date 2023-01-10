import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class WillowBleConnectionManager {
  WillowBleConnectionManager(FlutterReactiveBle ble) : _ble = ble;

  final FlutterReactiveBle _ble;

  /// connect to device
  /// scan should be stopped by  cancelling subscription
  Stream<ConnectionStateUpdate> connectDevice(
    String deviceId, {
    Duration connectionTimeout = const Duration(seconds: 5),
  }) async* {
    yield* _ble.connectToDevice(
      id: deviceId,
      connectionTimeout: connectionTimeout,
    );
  }
}
