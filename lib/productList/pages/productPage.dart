import "package:flutter/material.dart";
import "../product_manager.dart";
import "../appBar.dart";

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppBar(),
      appBar: AppBar(title: Text("EasyList")),
      body: ProductManager(),
    );
  }
}
