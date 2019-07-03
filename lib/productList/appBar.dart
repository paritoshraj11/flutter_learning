import 'package:scoped_model/scoped_model.dart';
import "package:flutter/material.dart";
import '../scopedModel/main.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
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
                onTap: () =>
                    Navigator.pushReplacementNamed(context, "/products"),
              ),
              ListTile(
                title: Text("Manage Product"),
                leading: Icon(Icons.settings),
                onTap: () =>
                    Navigator.pushReplacementNamed(context, "/admin-product"),
              ),
              ListTile(
                  title: Text("Logout"),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () {
                    model.removeAuthenticatedUser();
                    Navigator.pushReplacementNamed(context, "/");
                  })
            ],
          ),
        );
      },
    );
  }
}
