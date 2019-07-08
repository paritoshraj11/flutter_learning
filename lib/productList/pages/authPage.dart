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
  GlobalKey<FormState> _authFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  void _showSnackBar(BuildContext context, String msg) {
    final snackbar = SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
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
        if (!_authFormKey.currentState.validate()) {
          return;
        }
        _authFormKey.currentState.save();
        if (_auth == Auth.SignUp) {
          model
              .createUser(_authData["email"], _authData["password"])
              .then((value) {
            if (value) _showSnackBar(context, "User Created");
          }).catchError((error) {
            _showSnackBar(context, error.toString());
          });
        } else {
          model
              .authentiacteuser(_authData["email"], _authData["password"])
              .then((value) {
            if (value) {
              //redirect to the list page
            }
          }).catchError((error) {
            _showSnackBar(context, error.toString());
          });
        }
        //set dummy authenticated user
        // model.setAuthenticatedUser(
        //     email: "paritoshraj11@gmail.com", password: "testing");
        // Navigator.pushReplacementNamed(context, "/products");
      },
    );
  }

  _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Email", filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return "Enter Email Address";
        }

        String p =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(p);
        if (!regExp.hasMatch(value)) {
          return "Enter valid Email Address";
        }
        return null;
      },
      onSaved: (String value) {
        _authData["email"] = value;
      },
    );
  }

  _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Password", filled: true, fillColor: Colors.white),
      obscureText: true,
      controller: _passwordController,
      onSaved: (String value) {
        _authData["password"] = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return "Either password is Empty or Invalid";
        }
        if (value.length < 6) {
          return "at lease 6 character required";
        }
        return null;
      },
    );
  }

  _confirmPasswordTextField() {
    return _auth == Auth.SignUp
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
        : Container();
  }

  _layoutBuilder(context, targetWidth, model) {
    var l = new List<Widget>();

    l.add(Container(
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
                key: _authFormKey,
                child: Column(
                  children: <Widget>[
                    _emailTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    _passwordTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    _confirmPasswordTextField(),
                    _authActionBuilder(context, model),
                    _authOption(context)
                  ],
                ),
              ),
            )),
      ),
    ));

    if (model.loadingUserStatus) {
      l.add(Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.3,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.grey,
            ),
          ),
          Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          )
        ],
      ));
    }
    return l;
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
            return Stack(
              children: _layoutBuilder(context, targetWidth, model),
            );
          },
        ));
      },
    );
  }
}
