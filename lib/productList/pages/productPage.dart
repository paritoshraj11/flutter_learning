import "package:flutter/material.dart";
import "../product_manager.dart";
import "../appBar.dart";

class ProductsPage extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function removeProduct;
  ProductsPage(this.products, this.addProduct,
      this.removeProduct); //receving and passing product state related utility
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppBar(),
      appBar: AppBar(title: Text("EasyList")),
      body: ProductManager(products,addProduct,removeProduct ),
    );
  }
}
