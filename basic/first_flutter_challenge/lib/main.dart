import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Challenge'),
          backgroundColor: Colors.green,
          elevation: 0,
        ),
        body: const ItemsEditor(),
      ),
    );
  }
}

class ItemsEditor extends StatefulWidget {
  const ItemsEditor({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ItemsState();
  }
}

class ItemsState extends State<ItemsEditor> {
  List<Item> items = Repository().getItems();

  _onHandleResetButtonClick() {
    setState(() {
      items = Repository().getItems(invalidateCache: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: _onHandleResetButtonClick,
                child: const Text('Reset all items')),
          ],
        ),
        Expanded(
            child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: items.length,
          itemBuilder: (_, int index) => ItemList(item: items[index]),
        ))
      ],
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({Key? key, required Item item})
      : _item = item,
        super(key: key);
  final Item _item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _item._isChecked ? Colors.grey[800] : null,
      child: Container(
        height: 100,
        width: 100,
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            _item._content,
            style: TextStyle(color: (_item._isChecked ? Colors.white : null)),
          ),
        ),
      ),
    );
  }
}

class Item {
  final int _id;
  final String _content;
  final bool _isChecked;

  const Item(int id, String content, bool isChecked)
      : _id = id,
        _content = content,
        _isChecked = isChecked;
}

class Repository {
  List<Item> getItems({bool invalidateCache = false}) {
    return DataSource().getItems(invalidateCache: invalidateCache);
  }
}

class DataSource {
  static final List<Item> items = [];

  List<Item> getItems({bool invalidateCache = false}) {
    if (invalidateCache) {
      items.clear();
    }
    if (items.isEmpty) {
      generateItems();
    }
    return items;
  }

  generateItems() {
    for (var i = 0; i <= 1000; i++) {
      items.add(Item(i, Utils.generateRandomString(30),
          Utils.generateRandomEnabledState()));
    }
  }
}

class Utils {
  static String generateRandomString(int len) {
    var random = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[random.nextInt(_chars.length)])
        .join();
  }

  static bool generateRandomEnabledState() {
    var random = Random();
    return random.nextInt(2) == 0 ? false : true;
  }
}
