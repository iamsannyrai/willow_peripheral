import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import '../willow_ble/hub/willow_hub_interactor.dart';
import 'willow_hub_manager.dart';

class WillowWifi {
  static final WillowWifi instance = WillowWifi._internal();

  factory WillowWifi() => instance;

  WillowWifi._internal();

  late WillowHubManager willowHubManager;

  /// init function initializes hub interactor, hub wifi manager and hubMqtt manager
  void init() {
    final FlutterReactiveBle ble = FlutterReactiveBle();
    final hubInteractor = WillowHubInteractor(ble);
    willowHubManager = WillowHubManager(
      ble: ble,
      willowHubInteractor: hubInteractor,
    );
  }
}
