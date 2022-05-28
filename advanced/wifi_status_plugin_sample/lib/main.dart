import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi_plugin/wifi_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _connectivity = 'Disconnected';

  @override
  void initState() {
    super.initState();
    _getConnectivity();
    WifiPlugin.statusChanged(_connectivityHasChanged);
  }

  Future<void> _getConnectivity() async {
    final bool connectivity = await WifiPlugin.wifiStatus;
    setState(() {
      _connectivity = connectivity ? 'Connected' : 'Disconnected';
    });
  }

  void _connectivityHasChanged(bool hasConnectivity) {
    setState(() {
      _connectivity = hasConnectivity ? 'Connected' : 'Disconnected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _connectivity,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
