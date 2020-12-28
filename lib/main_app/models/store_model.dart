import 'package:seeya/main_app/models/product_model.dart';

class StoreModel{
  int storeId;
  String storeName;
  String storeLocation;
  List<ProductModel> productList;

  StoreModel({
    this.productList,
    this.storeId,
    this.storeName,
    this.storeLocation
  });
}

List<StoreModel> storeList1 = [
  StoreModel(
    storeId: 1,
    storeLocation: 'Mars',
    storeName: 'McDonalds',
    productList: []
  ),
  StoreModel(
      storeId: 2,
      storeLocation: 'Saturn',
      storeName: 'KFC',
      productList: []
  ),
  // StoreModel(
  //     storeId: 1,
  //     storeLocation: 'Mars',
  //     storeName: 'Pizza Hut',
  //     productList: []
  // )
];