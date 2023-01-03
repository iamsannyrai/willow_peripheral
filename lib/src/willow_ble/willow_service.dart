import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

abstract class WillowService {
  /// Hub service UUIDs
  static final Uuid hubServiceUuid =
      Uuid.parse("cb8655da-ffe9-46e0-923c-eb4e11eb99b9");
  static final Uuid hubProvSessionUuid =
      Uuid.parse("cb86ff51-ffe9-46e0-923c-eb4e11eb99b9");
  static final Uuid hubProvConfigUuid =
      Uuid.parse("cb86ff52-ffe9-46e0-923c-eb4e11eb99b9");
  static final Uuid hubProtoVerUuid =
      Uuid.parse("cb86ff53-ffe9-46e0-923c-eb4e11eb99b9");
  static final Uuid hubConfigUuid =
      Uuid.parse("cb86ff54-ffe9-46e0-923c-eb4e11eb99b9");

  /// Sensor service UUIDs
  static final Uuid sensorServiceUuid =
      Uuid.parse("db35b100-ca6d-42f1-90d6-0a6c4af8269d");
  static final Uuid sensorMeasUuid =
      Uuid.parse("db35b101-ca6d-42f1-90d6-0a6c4af8269d");
  static final Uuid sensorCtrlUuid =
      Uuid.parse("db35b102-ca6d-42f1-90d6-0a6c4af8269d");
  static final Uuid sensorDfuUuid =
      Uuid.parse("db35b103-ca6d-42f1-90d6-0a6c4af8269d");
}
