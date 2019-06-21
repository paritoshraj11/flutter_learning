import "package:flutter/material.dart";

class AddProduct extends StatefulWidget {
  final Function addProduct;
  AddProduct({this.addProduct});
  @override
  State<StatefulWidget> createState() {
    return _AddProduct();
  }
}

class _AddProduct extends State<AddProduct> {
  final Map<String, dynamic> _formData = {
    "title": null,
    "description": null,
    "price": null,
    "image": "assets/food.jpg"
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _onTiteChange(String value) {
    _formData["title"] = value;
  }

  _onDescriptionChange(String value) {
    _formData["descriptiom"] = value;
  }

  _onPriceChange(String value) {
    _formData["price"] = value;
  }

  _onSave() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    widget.addProduct(_formData);
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
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Price", icon: Icon(Icons.monetization_on)),
                  keyboardType: TextInputType.number,
                  onSaved: _onPriceChange,
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
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }
}
