import 'package:scoped_model/scoped_model.dart';
import "../model/product.dart";

class ProductModel extends Model {
  List<Product> _products = [];

  List<Product> get products {
    return List.from(_products); //new  reference of product list
  }

  //add method
  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  //remove method
  void removeProduct(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  //insert product at specified index
  void insertProduct(
    Product product,
    int index,
  ) {
    _products.insert(index, product);
    notifyListeners();
  }

  //updating product at specified index
  void updateProduct(int index, Product product) {
    _products[index] = product;
    notifyListeners();
  }

  void toogleFavourite(int index) {
    Product productItem = _products[index];
    _products[index] = Product(
        title: productItem.title,
        description: productItem.description,
        price: productItem.price,
        image: productItem.image,
        favourite: !productItem.favourite);
    notifyListeners();
  }
}
