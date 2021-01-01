import 'package:get/get.dart';
import 'package:seeya/main_app/models/product_model.dart';


class StoreModel{
  int storeId;
  String storeName;
  String storeImage;
  String storeLocation;
  List<int> cashBackList;
  List<ProductModel> productList;

  StoreModel({
    this.productList,
    this.storeId,
    this.storeName,
    this.storeImage,
    this.storeLocation,
    this.cashBackList
  });
}
