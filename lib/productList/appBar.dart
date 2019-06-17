import "package:flutter/material.dart";

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
            onTap: () => Navigator.pushReplacementNamed(context, "/products"),
          ),
          ListTile(
            title: Text("Manage Product"),
            leading: Icon(Icons.settings),
            onTap: () =>
                Navigator.pushReplacementNamed(context, "/admin-product"),
          )
        ],
      ),
    );
  }
}
