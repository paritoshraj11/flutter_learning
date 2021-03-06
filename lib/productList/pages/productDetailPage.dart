import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import 'package:flutter/widgets.dart';
import "package:async/async.dart";
import "../../model/product.dart";
import "../../scopedModel/main.dart";

class ProductDetailPage extends StatelessWidget {
  final int index;
  ProductDetailPage(this.index);

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
        }).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      print("on pop listen called");
      return Future.value(true);
    }, child: ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Product product = model.products[index];
        return Scaffold(
          appBar: AppBar(
            title: Text("Detail Page"),
          ),
          body: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                      product.image,
                      fit: BoxFit.fill,
                      height: 300,
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  product.title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(product.userEmail),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text("Description : ${product.description}"),
                  )
                ],
              ),
            ],
          ),
        );
      },
    ));
  }
}
