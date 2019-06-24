import "package:flutter/material.dart";
import "../product_manager.dart";
import "../appBar.dart";
import "../../model/product.dart";

class ProductsPage extends StatelessWidget {
  final List<Product> products;
  ProductsPage(
      this.products); //receving and passing product state related utility
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppBar(),
      appBar: AppBar(
        title: Text("Tastey Food"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          )
        ],
      ),
      body: ProductManager(products),
    );
  }
}
