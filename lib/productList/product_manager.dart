import 'package:flutter/material.dart';
import "./products.dart";
import "../model/product.dart";

class ProductManager extends StatelessWidget {
  final List<Product> products;

  ProductManager(this.products);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Products(products),
              padding: EdgeInsets.all(20),
            ),
          )
        ],
      ),
    );
  }
}
