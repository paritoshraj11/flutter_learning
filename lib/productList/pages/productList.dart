import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import "package:scoped_model/scoped_model.dart";
import "./addproductPage.dart";
import "../../model/product.dart";
import "../../scopedModel/main.dart";

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
              fit: BoxFit.contain, image: NetworkImage(this.imageAsset))),
    );
  }
}

class ProductList extends StatelessWidget {
  _onDismissed(
      BuildContext context,
      DismissDirection direction,
      Product product,
      int index,
      Function removeProduct,
      Function insertProduct) {
    final String productTitle = product.title;
    if (direction == DismissDirection.endToStart) {
      removeProduct(index).then((_) {
        final snackBar = SnackBar(
          content: Text("$productTitle has been deleted!"),
          backgroundColor: Theme.of(context).primaryColor,
          // action: SnackBarAction(
          //   textColor: Colors.white,
          //   label: "Undo",
          //   onPressed: () {
          //     insertProduct(product, index);
          //   },
          // ),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      });
    }
  }

  Widget _buildEditOption(BuildContext context, Product product, int index,
      Function updateProduct) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AddProduct(
                    index: index,
                  ))),
    );
  }

  Widget _itemBuilder(BuildContext context, int index, List<Product> products,
      MainModel model) {
    final Product product = products[index];
    return Dismissible(
      key: Key(product.title), //this must be unique
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (DismissDirection direction) => _onDismissed(context,
          direction, product, index, model.removeProduct, model.insertProduct),

      child: Card(
        child: ListTile(
          // contentPadding: EdgeInsets.all(20),
          leading: Avatar(product.image),
          //leading: Image.asset(product["image"]),
          title: Text(product.title),
          subtitle: Text("₹ ${product.price.toString()}"),
          trailing:
              _buildEditOption(context, product, index, model.updateProduct),
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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final List<Product> products = model.products;
        return ListView.separated(
            padding: EdgeInsets.only(top: 10),
            separatorBuilder: _seperatedBuilder,
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) =>
                _itemBuilder(context, index, products, model));
      },
    );
  }
}
