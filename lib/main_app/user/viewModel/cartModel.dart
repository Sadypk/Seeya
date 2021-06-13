import 'package:get/get.dart';
import 'package:seeya/main_app/models/productModel.dart';
import 'package:seeya/newMainAPIs.dart';

class CartItemModel{
  static RxList<ProductModel> products = <ProductModel>[].obs;
  static RxList<RawProduct> rawItem = <RawProduct>[].obs;
  static RxList<StoreData> selectedStore = <StoreData>[].obs; //made it a list to keep the continuity among other lists
  static Rx<int> walletAmount = 0.obs;
}
