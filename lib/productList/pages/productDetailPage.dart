import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import "package:async/async.dart";

class ProductDetailPage extends StatelessWidget {
  final Map<String, String> product;
  ProductDetailPage(this.product);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          print("on pop listen called");
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Detail Page"),
          ),
          body: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Image.asset(
                      product["image"],
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(product["title"]),
              ),
              Container(
                child: RaisedButton(
                  child: Text("Delete"),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              )
            ],
          ),
        ));
  }
}
