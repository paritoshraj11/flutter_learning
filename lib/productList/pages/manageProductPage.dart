import 'package:flutter/material.dart';
import '../appBar.dart';
import "./addproductPage.dart";
import "./productList.dart";

class ManageProduct extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function addProduct;
  final Function removeProduct;
  ManageProduct(this.products, this.addProduct, this.removeProduct);
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
      children: <Widget>[AddProduct(this.addProduct), ProductList()],
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
