import 'package:flutter/material.dart';
import "./product_manager.dart";
import "./layoutTutorial.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text("EasyList")),
      body: LayoutExample(),
      // body: ProductManager("Food tester !!")
    ));
  }
}
