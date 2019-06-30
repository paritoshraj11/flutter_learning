import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import "../model/product.dart";

class Products extends StatelessWidget {
  final List<Product> products;
  final Function toogleFavourite;
  final bool favouriteFilterStatus;
  Products(this.products, this.toogleFavourite, this.favouriteFilterStatus);

  Widget _listItem(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: <Widget>[
              Image.network(
                products[index].image,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          products[index].title,
                          style: TextStyle(
                              fontFamily: "Oswald",
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).accentColor),
                          child: Text(
                            '₹ ${products[index].price.toString()}',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )),
                    IconButton(
                      padding: EdgeInsets.only(right: 10),
                      color: Theme.of(context).primaryColor,
                      icon: Icon(products[index].favourite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () {
                        toogleFavourite(index);
                      },
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                        style: BorderStyle.solid)),
                child: Text("Sector 49, Gurgaon"),
              ),
            ],
          ),
        ),
      ),
      onTap: () =>
          Navigator.pushNamed(context, "/product-detail/$index").then((value) {
            print(value);
          }),
    );
  }

  Widget _buildList() {
    Widget renderWidget = Center(
      child: Text(
          "No ${favouriteFilterStatus ? "Favourite" : ""} Product Found, ${favouriteFilterStatus ? "Mark Favourite" : "Add Product"} !!"),
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
