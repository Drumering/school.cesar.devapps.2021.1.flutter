import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wifi_plugin_platform_interface.dart';

/// An implementation of [WifiPluginPlatform] that uses method channels.
class MethodChannelWifiPlugin extends WifiPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wifi_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
