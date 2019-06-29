import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import "./products.dart";
import "../scopedModel/productScopedModel.dart";

class ProductManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: ScopedModelDescendant<ProductModel>(
                builder:
                    (BuildContext context, Widget child, ProductModel model) =>
                        Products(model.products, model.toogleFavourite),
              ),
              padding: EdgeInsets.all(20),
            ),
          )
        ],
      ),
    );
  }
}
