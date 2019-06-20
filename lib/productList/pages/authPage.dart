import "package:flutter/material.dart";

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 500.0 ? 400 : deviceWidth * 0.95;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.8), BlendMode.dstATop),
                image: AssetImage("assets/foodbg.jpg"),
                fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                width: targetWidth,
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Email",
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text("Login",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, "/products"),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
