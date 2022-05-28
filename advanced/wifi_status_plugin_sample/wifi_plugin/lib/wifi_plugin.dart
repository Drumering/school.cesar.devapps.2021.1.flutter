import 'package:flutter/services.dart';

import 'wifi_plugin_platform_interface.dart';

class WifiPlugin {
  static const MethodChannel _channel = MethodChannel('wifi_plugin');

  static Future<bool> get wifiStatus async {
    final bool status = await _channel.invokeMethod('getWifiStatus');
    return status;
  }

  static void statusChanged(Function(bool hasConnectivity) callback) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onConnectivityChanged') {
        callback.call(call.arguments as bool);
      }
    });
  }

  Future<String?> getPlatformVersion() {
    return WifiPluginPlatform.instance.getPlatformVersion();
  }
}
