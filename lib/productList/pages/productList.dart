import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import "./addproductPage.dart";

class Avatar extends StatelessWidget {
  final String imageAsset;
  Avatar(this.imageAsset);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.contain, image: AssetImage(this.imageAsset))),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  ProductList({this.products, this.updateProduct});

  Widget _itemBuilder(BuildContext context, int index) {
    final Map<String, dynamic> product = products[index];
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        leading: Avatar(product["image"]),
        //leading: Image.asset(product["image"]),
        title: Text(product["title"]),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddProduct(
                        index: index,
                        product: product,
                        updateProduct: updateProduct,
                      ))),
        ),
      ),
    );
  }

  Widget _seperatedBuilder(BuildContext context, int index) {
    return SizedBox(
      height: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 10),
        separatorBuilder: _seperatedBuilder,
        itemCount: products.length,
        itemBuilder: _itemBuilder);
  }
}
