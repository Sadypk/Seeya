import 'package:get/get.dart';
import 'package:seeya/main_app/models/product_model.dart';

class CartViewModel extends GetxController{
  var cartItems = <ProductModel>[].obs;

  addToCart(ProductModel v){
    cartItems.add(v);
  }

  removeFromCart(ProductModel v){
    cartItems.removeWhere((element) => element.productId==v.productId);
  }

  isInCart(ProductModel v){
    return cartItems.contains(v);
  }

  clearCart(){
    cartItems.clear();
  }
}