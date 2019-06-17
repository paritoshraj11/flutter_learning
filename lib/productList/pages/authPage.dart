import "package:flutter/material.dart";
import "./productPage.dart";

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text("Login",
                style: TextStyle(
                  color: Colors.white,
                )),
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ProductsPage())),
          ),
        ),
      ),
    );
  }
}
