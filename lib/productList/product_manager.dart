import 'package:flutter/material.dart';
import "./products.dart";

class ProductManager extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function removeProduct;
  ProductManager(this.products, this.addProduct, this.removeProduct);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text("Add Product", style: TextStyle(color: Colors.white)),
              onPressed: () {
                addProduct(
                    {"title": "Healthy food", "image": "assets/food.jpg"});
              },
            ),
          ),
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
