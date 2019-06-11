import 'package:flutter/material.dart';
import "./products.dart";

class ProductManager extends StatefulWidget {
  final String startingProduct;
  ProductManager(this.startingProduct) {
    print("[product Manager] :: constructor");
  }
  @override
  State<StatefulWidget> createState() {
    print("[product Manager] :: create state");
    return _ProductManager();
  }
}

class _ProductManager extends State<ProductManager> {
  List<String> _products = [];
  /*
  ** in class which extends  State class is able to acsess all
  property of statefull widget with special object widget.property name;
  ** we can not just initialize class member with declaration, 
  we can only use in methods , so initialzing veriable with 
  widget in initState

  */

  @override
  void initState() {
    print("[product Manager state] :: init state");
    _products.add(widget.startingProduct);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("[product Manager state] :: build");

    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              child: Text("Add Product"),
              onPressed: () {
                setState(() {
                  _products.add("Food 1");
                });
              },
            ),
          ),
          Products(_products)
        ],
      ),
    );
  }
}
