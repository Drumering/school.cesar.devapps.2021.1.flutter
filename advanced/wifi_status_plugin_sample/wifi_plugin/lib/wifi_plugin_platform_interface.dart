import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wifi_plugin_method_channel.dart';

abstract class WifiPluginPlatform extends PlatformInterface {
  /// Constructs a WifiPluginPlatform.
  WifiPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static WifiPluginPlatform _instance = MethodChannelWifiPlugin();

  /// The default instance of [WifiPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelWifiPlugin].
  static WifiPluginPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WifiPluginPlatform] when
  /// they register themselves.
  static set instance(WifiPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
