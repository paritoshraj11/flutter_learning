import "package:flutter/material.dart";

class ProductDetailPage extends StatelessWidget {
  final Map<String, String> product;
  ProductDetailPage(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  product["image"],
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(product["title"]),
          )
        ],
      ),
    );
  }
}
