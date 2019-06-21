import 'package:flutter/material.dart';
import '../appBar.dart';
import "./addproductPage.dart";
import "./productList.dart";

class ManageProduct extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function addProduct;
  final Function removeProduct;
  final Function updateProduct;
  ManageProduct(
      this.products, this.addProduct, this.removeProduct, this.updateProduct);
  _tabs() {
    return TabBar(
      tabs: <Widget>[
        Tab(
          text: "Add Product",
          icon: Icon(Icons.create),
        ),
        Tab(
          text: "Porduct List",
          icon: Icon(Icons.list),
        )
      ],
    );
  }

  _tabsView() {
    return TabBarView(
      children: <Widget>[
        AddProduct(
          addProduct: this.addProduct,
        ),
        ProductList(products: this.products, updateProduct: this.updateProduct)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          drawer: CustomAppBar(),
          appBar: AppBar(title: Text("Manage Product"), bottom: _tabs()),
          body: _tabsView()),
    );
  }
}
