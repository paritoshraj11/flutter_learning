import 'package:flutter/material.dart';
import "./products.dart";

class ProductManager extends StatefulWidget {
  final Map<String, String> startingProduct;
  ProductManager({this.startingProduct});
  @override
  State<StatefulWidget> createState() {
    return _ProductManager();
  }
}

class _ProductManager extends State<ProductManager> {
  List<Map<String, String>> _products = [];
  /*
  ** in class which extends  State class is able to acsess all
  property of statefull widget with special object widget.property name;
  ** we can not just initialize class member with declaration, 
  we can only use in methods , so initialzing veriable with 
  widget in initState

  */

  @override
  void initState() {
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("[product Manager state] :: build");

    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text("Add Product", style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  _products.add(
                      {"title": "Healthy food", "image": "assets/food.jpg"});
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              child: Products(_products),
              padding: EdgeInsets.all(20),
            ),
          )
        ],
      ),
    );
  }
}
