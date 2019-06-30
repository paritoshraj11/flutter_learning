import "package:scoped_model/scoped_model.dart";
import "./connectedModel.dart";

class MainModel extends Model with ConnectedModel, ProductModel, UserModel {}
