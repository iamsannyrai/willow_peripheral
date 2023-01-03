class WillowSensorMeasurement {
  final String deviceId;

  /// unix time
  final int timestamp;
  final int illuminance;

  /// temperature is in 100ths of °C
  final int temperature;
  final int soilHumidity;
  final int batteryLevel;
  final int flags;

  WillowSensorMeasurement({
    required this.deviceId,
    required this.timestamp,
    required this.illuminance,
    required this.temperature,
    required this.soilHumidity,
    required this.batteryLevel,
    required this.flags,
  });

  @override
  String toString() {
    return "{deviceId: $deviceId, timeStamp: $timestamp, illuminance: $illuminance, temperature: $temperature, soilHumidity: $soilHumidity, batteryLevel: $batteryLevel, flags: $flags}";
  }
}
