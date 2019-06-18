import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import "package:async/async.dart";

class ProductDetailPage extends StatelessWidget {
  final Map<String, String> product;
  ProductDetailPage(this.product);

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you Sure ?"),
            content: Text("This will not remove!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Confirm"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        }).then((value) {
      print("123456789045678 $value");
    });
  }

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
                  onPressed: () => _showDialog(context),
                ),
              )
            ],
          ),
        ));
  }
}
