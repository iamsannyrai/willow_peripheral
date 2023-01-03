import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import '../willow_service.dart';

class WillowSensorCharacteristic {
  static QualifiedCharacteristic meas(String deviceId) =>
      QualifiedCharacteristic(
        serviceId: WillowService.sensorServiceUuid,
        characteristicId: WillowService.sensorMeasUuid,
        deviceId: deviceId,
      );

  static QualifiedCharacteristic ctrl(String deviceId) =>
      QualifiedCharacteristic(
        serviceId: WillowService.sensorServiceUuid,
        characteristicId: WillowService.sensorCtrlUuid,
        deviceId: deviceId,
      );

  static QualifiedCharacteristic dfu(String deviceId) =>
      QualifiedCharacteristic(
        serviceId: WillowService.sensorServiceUuid,
        characteristicId: WillowService.sensorDfuUuid,
        deviceId: deviceId,
      );
}
