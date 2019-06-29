import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import "./products.dart";
import "../scopedModel/main.dart";

class ProductManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: ScopedModelDescendant<MainModel>(
                builder:
                    (BuildContext context, Widget child, MainModel model) =>
                        Products(model.filterProduct, model.toogleFavourite,
                            model.productFilterStatus),
              ),
              padding: EdgeInsets.all(20),
            ),
          )
        ],
      ),
    );
  }
}
