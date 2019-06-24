import 'package:flutter/material.dart';
import '../appBar.dart';
import "./addproductPage.dart";
import "./productList.dart";
import "../../model/product.dart";

class ManageProduct extends StatelessWidget {
  final List<Product> products;
  final Function addProduct;
  final Function removeProduct;
  final Function updateProduct;
  final Function insertProduct;
  ManageProduct(this.products, this.addProduct, this.removeProduct,
      this.updateProduct, this.insertProduct);
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
        ProductList(
            products: this.products,
            updateProduct: this.updateProduct,
            removeProduct: this.removeProduct,
            insertProduct: this.insertProduct)
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
