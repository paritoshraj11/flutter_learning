import 'package:flutter/material.dart';
import "./productList/pages/authPage.dart";
import "./productList/pages/productPage.dart";
import "./productList/pages/productDetailPage.dart";
import "./productList/pages/manageProductPage.dart";

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
      theme: ThemeData(
          accentColor: Colors.deepPurple, primarySwatch: Colors.deepOrange),
      routes: {
        "/": (BuildContext context) =>
            Auth(), //it is default route of the application.
        "/products": (BuildContext context) =>
            ProductsPage(_products, _addProduct, _removeProduct),
        "/admin-product": (BuildContext context) => ManageProduct()
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split("/");
        if (pathElements[0] != "") {
          return null;
        }
        if (pathElements[1] == "product-detail") {
          final index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  ProductDetailPage(_products[index]));
        }

        return null;
      },
    );
  }
}
