import "package:flutter/material.dart";

class Products extends StatelessWidget {
  final List<String> products;
  Products(this.products) {
    print("[product widget] :: constructor");
  }
  @override
  Widget build(BuildContext context) {
    print("[product widget] :: build");
    return Column(
      children: products
          .map((element) => (Card(
                child: Column(
                  children: <Widget>[
                    // Image.asset(
                    //   "assets/food.jpg",
                    // ),
                    Text(element)
                  ],
                ),
              )))
          .toList(),
    );
  }
}
