import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import "./addproductPage.dart";

class Avatar extends StatelessWidget {
  final String imageAsset;
  Avatar(this.imageAsset);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.contain, image: AssetImage(this.imageAsset))),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  final Function removeProduct;
  final Function insertProduct;
  ProductList(
      {this.products,
      this.updateProduct,
      this.removeProduct,
      this.insertProduct});

  _onDismissed(BuildContext context, DismissDirection direction,
      Map<String, dynamic> product, int index) {
    print(direction);
    if (direction == DismissDirection.endToStart) {
      removeProduct(index);
      print("dismissed start to end");
      final snackBar = SnackBar(
        content: Text("${product["title"]} has been deleted!"),
        backgroundColor: Theme.of(context).primaryColor,
        action: SnackBarAction(
          textColor: Colors.white,
          label: "Undo",
          onPressed: () {
            insertProduct(product, index);
          },
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  Widget _buildDeleteOption(
      BuildContext context, Map<String, dynamic> product, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AddProduct(
                    index: index,
                    product: product,
                    updateProduct: updateProduct,
                  ))),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final Map<String, dynamic> product = products[index];
    return Dismissible(
      key: Key(product["title"]), //this must be unique
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (DismissDirection direction) =>
          _onDismissed(context, direction, product, index),

      child: Card(
        child: ListTile(
          // contentPadding: EdgeInsets.all(20),
          leading: Avatar(product["image"]),
          //leading: Image.asset(product["image"]),
          title: Text(product["title"]),
          subtitle: Text("₹ ${product["price"].toString()}"),
          trailing: _buildDeleteOption(context, product, index),
        ),
      ),
    );
  }

  Widget _seperatedBuilder(BuildContext context, int index) {
    return SizedBox(
      height: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 10),
        separatorBuilder: _seperatedBuilder,
        itemCount: products.length,
        itemBuilder: _itemBuilder);
  }
}
