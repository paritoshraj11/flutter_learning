import "package:flutter/material.dart";

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
            onPressed: () =>
                Navigator.pushReplacementNamed(context, "/products"),
          ),
        ),
      ),
    );
  }
}
