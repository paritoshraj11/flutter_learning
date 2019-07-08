import 'package:flutter/material.dart';
import '../appBar.dart';
import "./addproductPage.dart";
import "./productList.dart";

class ManageProduct extends StatelessWidget {
  _tabs() {
    return TabBar(
      tabs: <Widget>[
        Tab(
          text: "Porduct List",
          icon: Icon(Icons.list),
        ),
        Tab(
          text: "Add Product",
          icon: Icon(Icons.create),
        ),
      ],
    );
  }

  _tabsView() {
    return TabBarView(
      children: <Widget>[
        ProductList(),
        AddProduct(),
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
