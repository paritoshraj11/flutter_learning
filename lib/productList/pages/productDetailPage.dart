import "package:flutter/material.dart";

class ProductDetailPage extends StatelessWidget {
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
                  "assets/food.jpg",
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text("This is Detail page"),
          )
        ],
      ),
    );
  }
}
