import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Task 2'),
          backgroundColor: Colors.green,
        ),
        body: const TextEditor(),
      ),
    ));
  }
}

class TextEditor extends StatefulWidget {
  const TextEditor({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TextEditorState();
  }
}

class TextEditorState extends State<TextEditor> {
  final controller = TextEditingController();
  String text = '';

  _onHandleTextChange() {
    setState(() {
      text = controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: 'Text to change'),
        ),
        ElevatedButton(
            onPressed: _onHandleTextChange, child: const Text('Set text')),
        Text(text),
      ],
    ));
  }
}

class Description extends StatelessWidget {
  const Description({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Essa é a descrição do app');
  }
}
