import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import "./productList/pages/authPage.dart";
import "./productList/pages/productPage.dart";
import "./productList/pages/productDetailPage.dart";
import "./productList/pages/manageProductPage.dart";
import "./model/product.dart";

void main() {
  //debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  List<Product> _products = [];

  _addProduct(Product product) {
    setState(() {
      _products.add(product);
    });
  }

  _insertProduct(Product product, index) {
    setState(() {
      _products.insert(index, product);
    });
  }

  _updateProduct(int index, Product product) {
    setState(() {
      _products[index] = product;
    });
  }

  _removeProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: Colors.deepPurple, primarySwatch: Colors.deepOrange),
      routes: {
        "/": (BuildContext context) =>
            Auth(), //it is default route of the application.
        "/products": (BuildContext context) => ProductsPage(_products),
        "/admin-product": (BuildContext context) => ManageProduct(_products,
            _addProduct, _removeProduct, _updateProduct, _insertProduct)
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
