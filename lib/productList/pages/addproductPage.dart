import "package:flutter/material.dart";

class AddProduct extends StatefulWidget {
  final Function addProduct;
  AddProduct(this.addProduct);
  @override
  State<StatefulWidget> createState() {
    return _AddProduct();
  }
}

class _AddProduct extends State<AddProduct> {
  String title = "";
  String description = "";
  double price = 0.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _onTiteChange(String value) {
    setState(() {
      title = value;
    });
  }

  _onDescriptionChange(String value) {
    setState(() {
      description = value;
    });
  }

  _onPriceChange(String value) {
    setState(() {
      price = double.parse(value);
    });
  }

  _onSave() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final Map<String, dynamic> product = {
      "title": title,
      "description": description,
      "price": price,
      "image": "assets/food.jpg"
    };
    widget.addProduct(product);
    Navigator.popAndPushNamed(context, "/products");
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(15.0),
          width: 100,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Title",
                    icon: Icon(Icons.title),
                  ),
                  onSaved: _onTiteChange,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Title is required";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Description", icon: Icon(Icons.description)),
                  maxLines: 4,
                  onSaved: _onDescriptionChange,
                  //onChanged: _onDescriptionChange,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Price", icon: Icon(Icons.monetization_on)),
                  keyboardType: TextInputType.number,
                  onSaved: _onPriceChange,
                  // onChanged: _onPriceChange,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      onPressed: _onSave),
                )
              ],
            ),
          )),
      onTap: () {
        print("on tap called !!!!!");
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }
}
