import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    var check = false.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Order', style: TextStyle(color: Colors.black87),),
        actions: [
          IconButton(icon: FaIcon(FontAwesomeIcons.comments, color: Colors.blue,), onPressed: (){})
        ],
      ),
      body: Obx((){
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(value: check.value, onChanged: (v){check.value = v;}),
                      Text('Message me if any items is missed or replaced items.')
                    ],
                  ),
                  SizedBox(height: 5,),
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
            ),
            _buildBottomDrawer(context)
          ],
        );
      }),
    );
  }

  double _headerHeight = 50;
  double _bodyHeight = 200;
  BottomDrawerController _controller = BottomDrawerController();

  Widget _buildBottomDrawer(BuildContext context) {
    return BottomDrawer(
      header: _buildBottomDrawerHead(context),
      body: _buildBottomDrawerBody(context),
      headerHeight: _headerHeight,
      drawerHeight: _bodyHeight,
      color: Colors.lightBlueAccent,
      controller: _controller,
    );
  }

  Widget _buildBottomDrawerHead(BuildContext context) {
    return Container(
      height: _headerHeight,
      child: Center(child: Icon(Icons.drag_handle, color: Colors.white,),),
    );
  }

  Widget _buildBottomDrawerBody(BuildContext context){
    TextEditingController cartTextController = TextEditingController();
    var enterCartItemsText = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[300], width: 1),
                // boxShadow: [
                //   BoxShadow(
                //       color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
                //   BoxShadow(
                //       color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
                // ],
              ),
              child: TextFormField(
                controller: cartTextController,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    // hintText: StringResources.enterRedeemBalanceText,
                    hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)
                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          InkWell(
            onTap: (){
              CartViewModel vm = Get.find();
              if(cartTextController.text.trim().length != 0){
                vm.addItemsFromText(cartTextController.text);
              }
              cartTextController.clear();
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(3)
              ),
              child: Center(
                child: Text('Enter', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
              ),
            ),
          )
        ],
      ),
    );
    CartViewModel vm = Get.find();
    return Obx((){
      return Container(
        height: _bodyHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Items added to cart: '+(vm.cartItems.length+vm.cartManualItems.length).toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  // InkWell(
                  //   onTap: (){
                  //     if((vm.cartManualItems.length+vm.cartItems.length)>0){
                  //       vm.confirmCart();
                  //       Get.to(ConfirmOrderScreen());
                  //     }
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(50),
                  //     ),
                  //     child: Center(
                  //       child: Text('Proceed', style: TextStyle(color: vm.cartItems.length==0?Colors.grey:Colors.lightBlueAccent, fontWeight: FontWeight.bold),),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              SizedBox(height: 10,),
              enterCartItemsText,
              SizedBox(height: 10,),
              Container(
                height: 50,
                child: ListView.builder(
                    itemCount: vm.cartManualItems.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index){
                      return InkWell(
                        onTap: (){
                          vm.cartManualItems.removeWhere((x) => x.productName == vm.cartManualItems[index].productName);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10, top: 10),
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(child: Row(
                            children: [
                              Text(vm.cartManualItems[index].productName, style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),),
                              SizedBox(width: 5,),
                              FaIcon(FontAwesomeIcons.solidTimesCircle, color: Colors.red, size: 14,),
                            ],
                          )),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

}
