import 'package:flutter/material.dart';
import "./productList/pages/homePage.dart";
// import "./layoutTutorial.dart";
//import "./networkRequest.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
