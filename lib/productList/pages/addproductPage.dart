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
    return Container(
      padding: EdgeInsets.all(15.0),
      child: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Title",
              icon: Icon(Icons.title),
            ),
            onChanged: _onTiteChange,
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "Description", icon: Icon(Icons.description)),
            maxLines: 4,
            onChanged: _onDescriptionChange,
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "Price", icon: Icon(Icons.monetization_on)),
            keyboardType: TextInputType.number,
            onChanged: _onPriceChange,
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
    );
  }
}
