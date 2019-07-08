import "package:scoped_model/scoped_model.dart";
import "package:http/http.dart" as http;
import 'package:firebase_auth/firebase_auth.dart';
import "dart:convert";
import "dart:async";
import "dart:io";
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import "../model/user.dart";
import "../model/product.dart";

class ConnectedModel extends Model {
  User _authenticatedUser;
  //creating dummy uset becasue its loose when app refresh;
  List<Product> _products = [];
  bool _loading = false;
  String get FIREBASE_URL {
    return "https://my-products-370c8.firebaseio.com/products.json";
  }

  bool get loadingStatus {
    return _loading;
  }

  Future<Map<String, dynamic>> _uploadImage(File image,
      {String imagePath}) async {
    //find type of file for naming
    final mimeTypeData = lookupMimeType(image.path).split('/');

    //creating requst for uploading file it is multipart file request
    final imageUploadRequest = http.MultipartRequest(
        "POST",
        Uri.parse(
            'https://us-central1-my-products-370c8.cloudfunctions.net/storeImage'));

    final file = await http.MultipartFile.fromPath('image', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    //adding file in request
    imageUploadRequest.files.add(file);

    if (imagePath != null) {
      imageUploadRequest.fields['imagePath'] = Uri.encodeComponent(imagePath);
    }

    try {
      final streamResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamResponse);
      if (response.statusCode != 200 && response.statusCode != 201) {
        print(">>>> error in file upload methods without catch blao");
        return null;
      }

      final responseData = json.decode(response.body);
      return responseData;
    } catch (err) {
      print(">>> error in uploading $err");
      return null;
    }
  }

  //add method
  Future<dynamic> addProduct({title, description, price, image}) async {
    _loading = true;
    notifyListeners();

    final uploadImageData = await _uploadImage(image);
    if (uploadImageData == null) {
      return false;
    }

    final Map<String, dynamic> productData = {
      "title": title,
      "image": uploadImageData["imageUrl"],
      "imagePath": uploadImageData["imagePath"],
      "price": price,
      "description": description,
      "userEmail": _authenticatedUser.userEmail,
      "userId": _authenticatedUser.userId
    };
    return http
        .post(FIREBASE_URL, body: jsonEncode(productData))
        .then((http.Response response) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      Product product = Product(
          id: responseData["name"],
          title: title,
          image: uploadImageData["imageUrl"],
          imagePath: uploadImageData["imagePath"],
          price: price,
          description: description,
          userEmail: _authenticatedUser.userEmail,
          userId: _authenticatedUser.userId);
      _products.add(product);
      _loading = false;
      notifyListeners();
    }).catchError((err) {
      print("error in uploading data");
    });
  }

  //updating product at specified index
  Future<dynamic> updateProduct(
      {index, title, price, description, image, id}) async {
    //if image is not null then, new updated image is there

    print(">>>>>>>>> $image");

    Map<String, dynamic> updatedUploadedImage = {
      "imageUrl": _products[index].image,
      "imagePath": _products[index].imagePath
    };

    if (image != null) {
      updatedUploadedImage = await _uploadImage(image);
    }

    final Map<String, dynamic> productData = {
      "id": id,
      "title": title,
      "image": updatedUploadedImage["imageUrl"],
      "imagePath": updatedUploadedImage["imagePath"],
      "price": price,
      "description": description,
      "userEmail": _authenticatedUser.userEmail,
      "userId": _authenticatedUser.userId
    };
    return http
        .put("https://my-products-370c8.firebaseio.com/products/$id.json",
            body: json.encode(productData))
        .then((http.Response response) {
      Product product = Product(
          id: id,
          title: title,
          image: image,
          price: price,
          description: description,
          userEmail: _authenticatedUser.userEmail,
          userId: _authenticatedUser.userId);
      _products[index] = product;
      notifyListeners();
    }).catchError((error) {
      print("error  in updating product $json.decode(error");
    });
  }
}

class UserModel extends ConnectedModel {
  bool _userLoading = false;
  final FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;

  bool get loadingUserStatus {
    return _userLoading;
  }

  void setAuthenticatedUser({String userId, String userEmail}) {
    User user = User(userId: userId, userEmail: userEmail);
    _authenticatedUser = user;
    notifyListeners();
  }

  void loadCurrentUser() async {
    try {
      FirebaseUser user = await _firebaseAuthInstance.currentUser();
      setAuthenticatedUser(userId: user.uid, userEmail: user.email);
    } catch (err) {
      print(">>>>> getting error in laod current user $err");
    }
  }

  Future<bool> createUser(String email, String password) async {
    _userLoading = true;
    notifyListeners();
    try {
      FirebaseUser user = await _firebaseAuthInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      setAuthenticatedUser(userId: user.uid, userEmail: user.email);
      _userLoading = false;
      notifyListeners();
      return true;
    } catch (err) {
      _userLoading = false;
      notifyListeners();
      return throw ("some thing is worng in craeting user");
    }
  }

  Future<bool> authentiacteuser(String email, String password) async {
    _userLoading = true;
    notifyListeners();
    try {
      FirebaseUser user = await _firebaseAuthInstance
          .signInWithEmailAndPassword(email: email, password: password);
      setAuthenticatedUser(userId: user.uid, userEmail: user.email);
      _userLoading = false;
      notifyListeners();
      return true;
    } catch (err) {
      _userLoading = false;
      notifyListeners();
      return throw ("Email Id or password is incorrect");
    }
  }

  User get authenticatedUser {
    return _authenticatedUser;
  }

  void removeAuthenticatedUser() {
    _firebaseAuthInstance.signOut().then((_) {
      _authenticatedUser = null;
    });
  }
}

class ProductModel extends ConnectedModel {
  bool _isFavouriteOnly = false;

  List<Product> get products {
    return List.from(_products); //new  reference of product list
  }

  Future<Null> fetchProductsData() {
    _loading = true;
    notifyListeners();
    return http.get(FIREBASE_URL).then((http.Response response) {
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
  Future<dynamic> removeProductPermanent(Product product) async {
    String productId = product.id;
    Map<String, String> deleteBodyData = {"imagePath": product.imagePath};
    try {
      await http.post(
          "https://us-central1-my-products-370c8.cloudfunctions.net/deleteImage",
          body: json.encode(deleteBodyData));
    } catch (err) {
      print("/////......... deleting error $err");
    }
    return http
        .delete(
            "https://my-products-370c8.firebaseio.com/products/$productId.json")
        .then((http.Response response) {
      notifyListeners();
    }).catchError((error) {
      print("error in deleting product $error");
    });
  }

//remove method
  removeProduct(int index) {
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
