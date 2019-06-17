import 'package:flutter/material.dart';
import "./productList/pages/authPage.dart";
import "./productList/pages/productPage.dart";
import "./productList/pages/productDetailPage.dart";
import "./productList/pages/manageProductPage.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //home: Auth(),
        theme: ThemeData(
            accentColor: Colors.deepPurple, primarySwatch: Colors.deepOrange),
        routes: {
          "/": (BuildContext context) => Auth(),
          "/products": (BuildContext context) => ProductsPage(),
        });
  }
}
