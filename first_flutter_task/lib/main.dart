import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: const [
                  Text(
                    'Texto 1',
                  ),
                  Text(
                    'Texto 2',
                  )
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: const [
                  Text(
                    'Texto 3',
                  ),
                  Text(
                    'Texto 4',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
