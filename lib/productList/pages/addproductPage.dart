import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import "package:scoped_model/scoped_model.dart";
import "dart:async";
import "dart:io";
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
    // "image":
    //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSe6ZnKnyge08Te70utvmzC6limwep28zlj7ZIFAZkNo0SUCumf"
    //"image": "assets/food.jpg"
  };
  File _imageFile;
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

  _showLoadinIndicator(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              )
            ],
          );
        });
  }

  _onSave(context, addProduct, updateProduct, Product product) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (widget.index != null) {
      //in this case we always have product
      _showLoadinIndicator(context);
      updateProduct(
              id: product.id,
              index: widget.index,
              title: _formData["title"],
              description: _formData["description"],
              price: double.parse(_formData["price"]),
              image:
                  _imageFile) // in editing mode if it is not updated if is null
          .then((_) {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, "/products");
      });
    } else {
      _showLoadinIndicator(context);
      addProduct(
              title: _formData["title"],
              description: _formData["description"],
              price: double.parse(_formData["price"]),
              image: _imageFile)
          .then((_) {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, "/products");
      });
    }
  }

  _saveButtonBuilder(BuildContext context, MainModel model, Product product) {
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
        onPressed: () =>
            _onSave(context, model.addProduct, model.updateProduct, product));
  }

  void _getImage(BuildContext context, ImageSource source) async {
    ImagePicker.pickImage(source: source).then((File image) {
      setState(() {
        _imageFile = image;
      });
      Navigator.pop(context);
    }).catchError((err) {
      print(">>>> error on opening camera / gallery $err");
    });
  }

  Widget _imageButtonBuilder(BuildContext context) {
    return OutlineButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Icon(Icons.camera_alt), Text("Image")],
      ),
      onPressed: () {
        //create bottom sliide up modal
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Pick Image',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(),
                    FlatButton(
                        child: Text("Camera",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          _getImage(context, ImageSource.camera);
                        }),
                    Divider(),
                    FlatButton(
                      onPressed: () {
                        _getImage(context, ImageSource.gallery);
                      },
                      child: Text("Gallery",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              );
            });
      },
    );
  }

  Widget _imagePreviewBuilder(BuildContext context, Product product) {
    Widget imagePrivew = _imageFile != null
        ? Image.file(
            _imageFile,
            height: 300,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          )
        : product != null && product.image != null
            ? Image.network(product.image)
            : Container();
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: imagePrivew,
    );
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
                    SizedBox(
                      height: 15,
                    ),
                    _imageButtonBuilder(context),
                    _imagePreviewBuilder(context, product),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: _saveButtonBuilder(context, model, product),
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
