import "package:scoped_model/scoped_model.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "../model/user.dart";
import "../model/product.dart";

class ConnectedModel extends Model {
  User _authenticatedUser = User(
      userEmail: "paritoshraj11@gmail.com",
      userId: "234ertyucv345",
      userPassword: "helloOne123");
  //creating dummy uset becasue its loose when app refresh;

  List<Product> _products = [];

  bool _loading = false;

  String get FIREBASE_URL {
    return "https://my-products-370c8.firebaseio.com/products.json";
  }

  bool get loadingStatus {
    return _loading;
  }

  //add method
  void addProduct({title, description, price, image}) {
    final Map<String, dynamic> productData = {
      "title": title,
      "image": image,
      "price": price,
      "description": description,
      "userEmail": _authenticatedUser.userEmail,
      "userId": _authenticatedUser.userId
    };
    http
        .post(FIREBASE_URL, body: jsonEncode(productData))
        .then((http.Response response) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      Product product = Product(
          id: responseData["name"],
          title: title,
          image: image,
          price: price,
          description: description,
          userEmail: _authenticatedUser.userEmail,
          userId: _authenticatedUser.userId);
      _products.add(product);
      notifyListeners();
    }).catchError((err) {
      print("error in uploading data");
    });
  }

  //updating product at specified index
  void updateProduct({index, title, price, description, image}) {
    Product product = Product(
        title: title,
        image: image,
        price: price,
        description: description,
        userEmail: _authenticatedUser.userEmail,
        userId: _authenticatedUser.userId);
    _products[index] = product;
    notifyListeners();
  }
}

class UserModel extends ConnectedModel {
  void setAuthenticatedUser({String id, String email, String password}) {
    print("$email dfghmfghjfghjkg");
    User user =
        User(userId: "reandom_123", userEmail: email, userPassword: password);
    _authenticatedUser = user;
    notifyListeners();
  }

  User get authenticatedUser {
    return _authenticatedUser;
  }

  void removeAuthenticatedUser() {
    _authenticatedUser = null;
  }
}

class ProductModel extends ConnectedModel {
  bool _isFavouriteOnly = false;

  List<Product> get products {
    return List.from(_products); //new  reference of product list
  }

  fetchProductsData() {
    _loading = true;
    notifyListeners();
    http.get(FIREBASE_URL).then((http.Response response) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData == null) {
        _loading = false;
        notifyListeners();
        return;
      }
      List<Product> productsData = [];
      responseData.forEach((key, product) {
        productsData.add(Product(
            id: key,
            title: product["title"],
            image: product["image"],
            price: product["price"],
            description: product["description"],
            userEmail: product["userEmail"],
            userId: product["userId"]));
      });
      _products = productsData;
      _loading = false;
      notifyListeners();
    });
  }

  List<Product> get filterProduct {
    if (_isFavouriteOnly == false) {
      return List.from(_products);
    }
    return List.from(_products
        .where((product) => product.favourite == _isFavouriteOnly)
        .toList());
  }

  bool get productFilterStatus {
    return _isFavouriteOnly;
  }

  void toogleProductsFavouriteList() {
    _isFavouriteOnly = !_isFavouriteOnly;
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
