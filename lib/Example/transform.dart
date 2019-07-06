import 'package:flutter/material.dart';

class TransFormExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TransForm Demo"),
      ),
      body: Center(
        child: Transform.rotate(
          angle: 1.0,
          child: Container(
            height: 100,
            width: 100,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
