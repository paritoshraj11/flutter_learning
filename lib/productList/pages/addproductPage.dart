import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "../../helper/ensure_visible.dart";
import "../../model/product.dart";
import "../../scopedModel/main.dart";

class AddProduct extends StatefulWidget {
  final int index;
  AddProduct({this.index});
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
  final titleFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final priceFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _onTiteChange(String value) {
    _formData["title"] = value;
  }

  _onDescriptionChange(String value) {
    _formData["description"] = value;
  }

  _onPriceChange(String value) {
    _formData["price"] = value;
  }

  _onSave(addProduct, updateProduct) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final Product product = Product(
        title: _formData["title"],
        price: double.parse(_formData["price"]),
        description: _formData["description"],
        image: _formData["image"]);
    if (widget.index != null) {
      updateProduct(widget.index, product);
    } else {
      addProduct(product);
    }
    Navigator.popAndPushNamed(context, "/products");
  }

  _saveButtonBuilder(BuildContext context, MainModel model) {
    return RaisedButton(
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
        onPressed: () => _onSave(model.addProduct, model.updateProduct));
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth;
    final double targetPadding = deviceWidth - targetWidth;
    final Widget pageContent = ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Product product = null;
        if (widget.index != null) {
          product = model.products[widget.index];
        }
        return GestureDetector(
          child: Container(
              padding: EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                  children: <Widget>[
                    EnsureVisibleWhenFocused(
                        focusNode: titleFocusNode,
                        child: TextFormField(
                          focusNode: titleFocusNode,
                          decoration: InputDecoration(
                            labelText: "Title",
                            icon: Icon(Icons.title),
                          ),
                          initialValue: product != null ? product.title : "",
                          onSaved: _onTiteChange,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Title is required";
                            }
                          },
                        )),
                    EnsureVisibleWhenFocused(
                      focusNode: descriptionFocusNode,
                      child: TextFormField(
                        focusNode: descriptionFocusNode,
                        decoration: InputDecoration(
                            labelText: "Description",
                            icon: Icon(Icons.description)),
                        maxLines: 4,
                        onSaved: _onDescriptionChange,
                        initialValue:
                            product != null ? product.description : "",
                      ),
                    ),
                    EnsureVisibleWhenFocused(
                      child: TextFormField(
                        focusNode: priceFocusNode,
                        decoration: InputDecoration(
                            labelText: "Price",
                            icon: Icon(Icons.monetization_on)),
                        keyboardType: TextInputType.number,
                        onSaved: _onPriceChange,
                        initialValue:
                            product != null ? product.price.toString() : "",
                      ),
                      focusNode: priceFocusNode,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: _saveButtonBuilder(context, model),
                    )
                  ],
                ),
              )),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        );
      },
    );

    if (widget.index == null) {
      return pageContent;
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text("Edit Product"),
          ),
          body: pageContent);
    }
  }
}
