import 'package:flutter/material.dart';
import "./productList/pages/authPage.dart";
// import "./layoutTutorial.dart";
//import "./networkRequest.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Auth(),
      theme: ThemeData(
          accentColor: Colors.deepPurple, primarySwatch: Colors.deepOrange),
    );
  }
}
