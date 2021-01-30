import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/store/view_model/cart_view_model.dart';
import 'package:seeya/main_app/models/product_model.dart';

class ConfirmOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CartViewModel());
    CartViewModel vm = Get.find();

    itemQuantityControllerTile(ProductModel x){
      return Container(
        height: 60,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(x.productName),
                Row(
                  children: [
                    Container(
                      width: 25,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                          color: Colors.lightBlueAccent,
                          // border: Border.all(width: 1, color: Colors.blue)
                      ),
                      child: Center(
                        child: Icon(Icons.remove, color: Colors.white, size: 14,),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                        color: Colors.lightBlueAccent,
                        // border: Border.all(width: 1, color: Colors.blue)
                      ),
                      child: Center(
                        child: Text('1', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    Container(
                      width: 25,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                        color: Colors.lightBlueAccent,
                        // border: Border.all(width: 1, color: Colors.blue)
                      ),
                      child: Center(
                        child: Icon(Icons.add, color: Colors.white, size: 14,),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    List<Widget> cartList(){
      List<Widget> list = [Text('Cart Items', style: TextStyle(fontWeight: FontWeight.bold))];
      for(int i=0; i<vm.cartItems.length; i++){
        list.add(itemQuantityControllerTile(vm.cartItems[i]));
      }
      return list;
    }

    List<Widget> cartManualList(){
      List<Widget> list = [Text('Manual Items', style: TextStyle(fontWeight: FontWeight.bold),)];
      for(int i=0; i<vm.cartManualItems.length; i++){
        list.add(itemQuantityControllerTile(vm.cartManualItems[i]));
      }
      return list;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Order', style: TextStyle(color: Colors.black87),),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cartList(),
            ),
            SizedBox(height: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cartManualList(),
            )
          ],
        ),
      ),
    );
  }
}
