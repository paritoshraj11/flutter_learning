import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import "./productList/pages/authPage.dart";
import "./productList/pages/productPage.dart";
import "./productList/pages/productDetailPage.dart";
import "./productList/pages/manageProductPage.dart";
import 'package:first_app/scopedModel/main.dart';
//import './Example/stackExample.dart';

// void main() {
//   //debugPaintSizeEnabled = true;
//   runApp(StackApp());
// }

void main() {
  //debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  void initState() {
    _model.loadCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model:
          _model, //initiated product model calss here and pass down to the widget tree from here
      child: MaterialApp(
        theme: ThemeData(
            accentColor: Colors.deepPurple, primarySwatch: Colors.deepOrange),
        routes: {
          "/": (BuildContext context) => ScopedModelDescendant(
                builder: (BuildContext context, Widget child, MainModel model) {
                  if (model.authenticatedUser != null) {
                    return ProductsPage();
                  }
                  return AuthPage();
                },
              ), //it is default route of the application.
          "/products": (BuildContext context) => ProductsPage(),
          "/admin-product": (BuildContext context) => ManageProduct()
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split("/");
          if (pathElements[0] != "") {
            return null;
          }
          if (pathElements[1] == "product-detail") {
            final index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
                builder: (BuildContext context) => ProductDetailPage(index));
          }

          return null;
        },
      ),
    );
  }
}
