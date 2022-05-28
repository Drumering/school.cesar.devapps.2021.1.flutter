import 'package:flutter_test/flutter_test.dart';
import 'package:wifi_plugin/wifi_plugin.dart';
import 'package:wifi_plugin/wifi_plugin_platform_interface.dart';
import 'package:wifi_plugin/wifi_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWifiPluginPlatform 
    with MockPlatformInterfaceMixin
    implements WifiPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WifiPluginPlatform initialPlatform = WifiPluginPlatform.instance;

  test('$MethodChannelWifiPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWifiPlugin>());
  });

  test('getPlatformVersion', () async {
    WifiPlugin wifiPlugin = WifiPlugin();
    MockWifiPluginPlatform fakePlatform = MockWifiPluginPlatform();
    WifiPluginPlatform.instance = fakePlatform;
  
    expect(await wifiPlugin.getPlatformVersion(), '42');
  });
}
