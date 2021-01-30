import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/store/models/store_model.dart';
import 'package:seeya/features/store/view/store_screen.dart';
import 'package:seeya/features/store/view_model/cart_view_model.dart';
import 'package:seeya/main_app/models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel productModel;
  final bool goToStoreScreen;
  ProductCardWidget({this.productModel, this.goToStoreScreen=false});

  @override
  Widget build(BuildContext context) {
    Get.put(CartViewModel());
    CartViewModel vm = Get.find();
    // var cartList = vm.cartItems;
    return Obx((){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(-1,1),
                  color: Colors.grey[300],
                  spreadRadius: 1,
                  blurRadius: 1
              ),
            ],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: Colors.grey[400])
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                child: Image.network(productModel.productImage, fit: BoxFit.cover,),
              ),
            ),
            SizedBox(height: 2,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('In Store', style: TextStyle(color: Colors.red, fontSize: 12),),
                          SizedBox(height: 2,),
                          Text(productModel.cashBack.toString()+' back', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      IconButton(icon: Icon(vm.cartItems.contains(productModel)?Icons.remove_circle_outline_rounded:Icons.add_circle_outline_rounded, color: Colors.red,), onPressed: (){
                        if(goToStoreScreen){
                          vm.cartItems.clear();
                          Get.to(StoreScreen(storeModel: StoreModel(storeName: 'Test')));
                        }else{
                          if(vm.cartItems.contains(productModel)){
                            vm.cartItems.removeWhere((x) => x.productId == productModel.productId);
                          }else{
                            vm.cartItems.add(productModel);
                          }
                        }
                      })
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(productModel.productName, style: TextStyle(color: Colors.black54, fontSize: 13),),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
