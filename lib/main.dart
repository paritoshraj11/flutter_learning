import 'package:flutter/material.dart';
import "./productList/pages/authPage.dart";
import "./productList/pages/productPage.dart";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  List<Map<String, String>> _products = [];

  _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
  }

  _removeProduct(int index) {
    print("remove this product");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //home: Auth(),
        theme: ThemeData(
            accentColor: Colors.deepPurple, primarySwatch: Colors.deepOrange),
        routes: {
          "/": (BuildContext context) => Auth(),
          "/products": (BuildContext context) =>
              ProductsPage(_products, _addProduct, _removeProduct),
        });
  }
}
