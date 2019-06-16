import "package:flutter/material.dart";
import "./pages/productDetailPage.dart";

class Products extends StatelessWidget {
  final List<String> products;
  Products(this.products);

  Widget _listItem(BuildContext context, int index) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/food.jpg",
            ),
            Text(products[index]),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text("Detail Page"),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailPage())),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    Widget renderWidget = Center(
      child: Text("No Product Found, Please Add Product!!"),
    );
    if (products.length > 0) {
      renderWidget = ListView.builder(
        itemBuilder: _listItem,
        itemCount: products.length,
      );
    }
    return renderWidget;
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }
}
