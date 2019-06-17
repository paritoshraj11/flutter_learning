import "package:flutter/material.dart";
import "./pages/manageProductPage.dart";
import "./pages/productPage.dart";

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("Choose One"),
          ),
          ListTile(
            title: Text("Product List"),
            leading: Icon(Icons.list),
            onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ProductsPage())),
          ),
          ListTile(
            title: Text("Manage Product"),
            leading: Icon(Icons.settings),
            onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ManageProduct())),
          )
        ],
      ),
    );
  }
}
