import 'package:get/get.dart';
import 'package:seeya/features/store/models/cart_model.dart';
import 'package:seeya/main_app/models/product_model.dart';

class PurchasedProductViewModel extends GetxController{
  var purchasedList = <CartModel>[].obs;
}