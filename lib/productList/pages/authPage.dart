import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "../../scopedModel/main.dart";

enum Auth { SignUp, Login }

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPage();
  }
}

class _AuthPage extends State<AuthPage> {
  Auth _auth = Auth.Login;
  final Map<String, String> _authData = {"email": "", "password": ""};
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  void _showSnackBar(BuildContext context, String msg) {
    final snackbar = SnackBar(
      backgroundColor: Theme.of(context).accentColor,
      content: Text(msg),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  Widget _authOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Switched to"),
        FlatButton(
          child: Text(
            _auth == Auth.Login ? "Sign up" : "Login",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Theme.of(context).accentColor),
          ),
          onPressed: () {
            setState(() {
              _auth = _auth == Auth.Login ? Auth.SignUp : Auth.Login;
            });
          },
        )
      ],
    );
  }

  Widget _authActionBuilder(BuildContext context, MainModel model) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text(_auth == Auth.Login ? "Login" : " Sign up ",
          style: TextStyle(
            color: Colors.white,
          )),
      onPressed: () {
        if (!_formKey.currentState.validate()) {
          return;
        }
        _formKey.currentState.save();
        if (_auth == Auth.SignUp) {
          model
              .createUser(_authData["email"], _authData["password"])
              .then((vlue) {
            _showSnackBar(context, "User Created");
          });
        } else {
          model.authentiacteuser(_authData["email"], _authData["password"]);
        }
        //set dummy authenticated user
        // model.setAuthenticatedUser(
        //     email: "paritoshraj11@gmail.com", password: "testing");
        // Navigator.pushReplacementNamed(context, "/products");
      },
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 500.0 ? 400 : deviceWidth * 0.95;
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(body: Builder(
          builder: (BuildContext context) {
            return Container(
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  filled: true,
                                  fillColor: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Either email is empty or invalid";
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                _authData["email"] = value;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  filled: true,
                                  fillColor: Colors.white),
                              obscureText: true,
                              controller: _passwordController,
                              onSaved: (String value) {
                                _authData["password"] = value;
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Either password is Empty or Invalid";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _auth == Auth.SignUp
                                ? TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "ReEnter Password",
                                        filled: true,
                                        fillColor: Colors.white),
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "ReEnter password cant be empty ";
                                      }
                                      if (_passwordController.text != value) {
                                        return "Password did not matched";
                                      }
                                      return null;
                                    },
                                  )
                                : Container(),
                            _authActionBuilder(context, model),
                            _authOption(context)
                          ],
                        ),
                      ),
                    )),
              ),
            );
          },
        ));
      },
    );
  }
}
