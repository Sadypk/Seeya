import 'package:get/get.dart';
import 'package:seeya/features/store/models/cart_model.dart';
import 'package:seeya/main_app/models/product_model.dart';

class CartViewModel extends GetxController{
  var cartItems = <ProductModelOld>[].obs;
  var cartItemsWithQuantity = <CartModel>[].obs;
  var cartManualItemsWithQuantity = <CartModel>[].obs;


  addItemsFromText(String s){
    List<CartModel> list = [];
    String x='';
    for(int i=0; i<s.length; i++){
       if(s[i] == ','){
           list.add(CartModel(product: ProductModelOld(productName: x), count: 1));
         print(x);
         x = '';
       }else if(i+1==s.length){
         x = x+s[i];
         list.add(CartModel(product: ProductModelOld(productName: x), count: 1));
       }else{
         x = x+s[i];
       }
    }
    cartManualItemsWithQuantity.addAll(list);
  }

  clearEmptyModels(){
    cartItemsWithQuantity.removeWhere((element) => element.product == null);
    cartManualItemsWithQuantity.removeWhere((element) => element.product == null);
  }
}