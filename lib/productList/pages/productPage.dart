import "package:flutter/material.dart";
import "../product_manager.dart";
import "package:scoped_model/scoped_model.dart";
import "../appBar.dart";
import "../../scopedModel/productScopedModel.dart";

class ProductsPage extends StatelessWidget {
  //receving and passing product state related utility
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, ProductModel model) {
        return Scaffold(
          drawer: CustomAppBar(),
          appBar: AppBar(
            title: Text("Tastey Food"),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  model.productFilterStatus
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  model.toogleProductsFavouriteList();
                },
              )
            ],
          ),
          body: ProductManager(),
        );
      },
    );
  }
}
