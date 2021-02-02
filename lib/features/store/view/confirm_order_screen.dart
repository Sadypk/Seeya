import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/store/models/cart_model.dart';
import 'package:seeya/features/store/view_model/cart_view_model.dart';
import 'package:seeya/main_app/models/product_model.dart';

class ConfirmOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CartViewModel());
    CartViewModel vm = Get.find();

    itemQuantityControllerTile(int i, bool manual){
      CartViewModel VM = Get.find();
      return Obx((){
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
                  Text(manual?VM.cartManualItemsWithQuantity[i].product.productName:VM.cartItemsWithQuantity[i].product.productName),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          if(manual){
                            VM.cartManualItemsWithQuantity[i].count--;
                            print(VM.cartManualItemsWithQuantity[i].count);
                          }else{
                            VM.cartItemsWithQuantity[i].count--;
                            print(VM.cartItemsWithQuantity[i].count);
                          }
                        },
                        child: Container(
                          width: 25,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                            color: Colors.lightBlueAccent,
                            // border: Border.all(width: 1, color: Colors.blue)
                          ),
                          child: Center(
                            child: Icon(Icons.remove, color: (manual?VM.cartManualItemsWithQuantity[i].count:VM.cartItemsWithQuantity[i].count)>0?Colors.white:Colors.grey, size: 14,),
                          ),
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
                          child: Text('${manual?VM.cartManualItemsWithQuantity[i] .count:VM.cartItemsWithQuantity[i].count}', style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          if(manual){
                            VM.cartManualItemsWithQuantity[i].count++;
                            print(VM.cartManualItemsWithQuantity[i].count);
                          }else{
                            VM.cartItemsWithQuantity[i].count++;
                            print(VM.cartItemsWithQuantity[i].count);
                          }
                        },
                        child: Container(
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
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
    }

    List<Widget> cartList(){
      List<Widget> list = [Text('Cart Items', style: TextStyle(fontWeight: FontWeight.bold))];
      for(int i=0; i<vm.cartItems.length; i++){
        list.add(itemQuantityControllerTile(i, false));
      }
      return list;
    }

    List<Widget> cartManualList(){
      List<Widget> list = [Text('Manual Items', style: TextStyle(fontWeight: FontWeight.bold),)];
      for(int i=0; i<vm.cartManualItems.length; i++){
        list.add(itemQuantityControllerTile(i, true));
      }
      return list;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Order', style: TextStyle(color: Colors.black87),),
      ),
      body: Obx((){
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              if(vm.cartItemsWithQuantity.length!=0)Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cartList(),
              ),
              SizedBox(height: 30,),
              if(vm.cartManualItemsWithQuantity.length!=0)Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cartManualList(),
              ),
              SizedBox(height: 20,),
              FlatButton(onPressed: null, child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: Text('Submit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ))
            ],
          ),
        );
      }),
    );
  }
}
