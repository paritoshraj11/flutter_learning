import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import "./products.dart";
import "../scopedModel/main.dart";

class ProductManager extends StatefulWidget {
  final Function fetchProductData;
  ProductManager(this.fetchProductData);
  @override
  State<StatefulWidget> createState() {
    return _ProductManager();
  }
}

class _ProductManager extends State<ProductManager> {
  @override
  void initState() {
    widget.fetchProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model) {
                  if (model.loadingStatus) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                        //backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                  }
                  return Products(model.filterProduct, model.toogleFavourite,
                      model.productFilterStatus, model.fetchProductsData);
                },
              ),
              padding: EdgeInsets.all(20),
            ),
          )
        ],
      ),
    );
  }
}
