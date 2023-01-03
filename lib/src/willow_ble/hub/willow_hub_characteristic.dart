import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import '../willow_service.dart';

class WillowHubCharacteristic {
  static QualifiedCharacteristic provSession(String deviceId) =>
      QualifiedCharacteristic(
        deviceId: deviceId,
        serviceId: WillowService.hubServiceUuid,
        characteristicId: WillowService.hubProvSessionUuid,
      );

  static QualifiedCharacteristic provConfig(String deviceId) =>
      QualifiedCharacteristic(
        deviceId: deviceId,
        serviceId: WillowService.hubServiceUuid,
        characteristicId: WillowService.hubProvConfigUuid,
      );

  static QualifiedCharacteristic protoVer(String deviceId) =>
      QualifiedCharacteristic(
        deviceId: deviceId,
        serviceId: WillowService.hubServiceUuid,
        characteristicId: WillowService.hubProtoVerUuid,
      );

  static QualifiedCharacteristic hubConfig(String deviceId) =>
      QualifiedCharacteristic(
        deviceId: deviceId,
        serviceId: WillowService.hubServiceUuid,
        characteristicId: WillowService.hubConfigUuid,
      );
}
