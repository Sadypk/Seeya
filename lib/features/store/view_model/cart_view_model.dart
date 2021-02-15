import 'package:get/get.dart';
import 'package:seeya/features/store/models/cart_model.dart';
import 'package:seeya/main_app/models/product_model.dart';

class CartViewModel extends GetxController{
  var cartItems = <ProductModel>[].obs;
  var cartManualItems = <ProductModel>[].obs;
  var cartItemsWithQuantity = <CartModel>[].obs;
  var cartManualItemsWithQuantity = <CartModel>[].obs;

  confirmCart(){
    cartManualItemsWithQuantity.clear();
    cartItemsWithQuantity.clear();
    cartItems.forEach((v) {cartItemsWithQuantity.add(CartModel(product: v));});
    cartManualItems.forEach((v) {cartManualItemsWithQuantity.add(CartModel(product: v));});
  }

  addItemsFromText(String s){
    List<ProductModel> list = [];
    String x='';
    for(int i=0; i<s.length; i++){
       if(s[i] == ','){
           list.add(ProductModel(productName: x));
         print(x);
         x = '';
       }else if(i+1==s.length){
         x = x+s[i];
         list.add(ProductModel(productName: x));
       }else{
         x = x+s[i];
       }
    }
    cartManualItems.addAll(list);
  }
}