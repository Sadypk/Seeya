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
    // vm.cartItemsWithQuantity.removeWhere((v) => v.count == 0);

    itemQuantityControllerTile(int i, bool manual){
      CartViewModel vm = Get.find();
      return Obx((){
        return Container(
          height: 60,
          margin: EdgeInsets.symmetric(vertical: 6),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(manual?vm.cartManualItemsWithQuantity[i].product.productName:vm.cartItemsWithQuantity[i].product.productName, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        if(manual){
                          vm.cartManualItemsWithQuantity[i].count--;
                          print(vm.cartManualItemsWithQuantity[i].count);
                        }else{
                          vm.cartItemsWithQuantity[i].count--;
                          print(vm.cartItemsWithQuantity[i].count);
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
                          child: Icon(Icons.remove, color: (manual?vm.cartManualItemsWithQuantity[i].count:vm.cartItemsWithQuantity[i].count)>0?Colors.white:Colors.grey, size: 14,),
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
                        child: Text('${manual?vm.cartManualItemsWithQuantity[i] .count:vm.cartItemsWithQuantity[i].count}', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        if(manual){
                          vm.cartManualItemsWithQuantity[i].count++;
                          print(vm.cartManualItemsWithQuantity[i].count);
                        }else{
                          vm.cartItemsWithQuantity[i].count++;
                          print(vm.cartItemsWithQuantity[i].count);
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
        );
      });
    }

    List<Widget> cartList(){
      List<Widget> list = [];
      for(int i=0; i<vm.cartItemsWithQuantity.length; i++){
        if(vm.cartItemsWithQuantity[i].count>0)list.add(itemQuantityControllerTile(i, false));
      }
      return list;
    }

    List<Widget> cartManualList(){
      List<Widget> list = [];
      for(int i=0; i<vm.cartManualItemsWithQuantity.length; i++){
        list.add(itemQuantityControllerTile(i, true));
      }
      return list;
    }

    var check = false.obs;
    var editAddress = false.obs;
    TextEditingController editAddressController = TextEditingController(text: 'Your address');
    var editAddressTextField = Obx((){
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Deliver to: ', style: TextStyle(fontWeight: FontWeight.bold),),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                // height: 50,
                child: TextFormField(
                  controller: editAddressController,
                  decoration: InputDecoration.collapsed(
                      enabled: editAddress.value,
                      // hintText: StringResources.enterRedeemBalanceText,
                      hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            InkWell(
              onTap: (){},
              child: Icon(editAddress.value?Icons.done:Icons.edit,size: 20, color: editAddress.value?Colors.green:Colors.grey,))
          ],
        ),
      );
    });
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Confirm Order', style: TextStyle(color: Colors.black87),),
          actions: [
            FlatButton(
              color: Colors.cyanAccent,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.lightBlueAccent
                  ),
                  child: Text('Contact Store', style: TextStyle(color: Colors.white),)),
            )
          ],
        ),
        body: Stack(
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
                  SizedBox(height: 10,),
                  editAddressTextField,

                  // SizedBox(height: 5,),
                  // if(vm.cartItemsWithQuantity.length!=0)Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: cartList(),
                  // ),
                  // SizedBox(height: 30,),
                  // if(vm.cartManualItemsWithQuantity.length!=0)Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: cartManualList(),
                  // ),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cartList(),
                  ),
                  // if(vm.cartManualItemsWithQuantity.isNotEmpty)Divider(height: 20,),
                  if(vm.cartManualItemsWithQuantity.isNotEmpty)Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cartManualList(),
                  ),
                  SizedBox(height: 20,),
                  FlatButton(onPressed: null, child: Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.only(bottom: 60),
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
        ),
      ),
    );
  }

  double _headerHeight = 80;
  double _bodyHeight = 80;
  BottomDrawerController _controller = BottomDrawerController();

  Widget _buildBottomDrawer(BuildContext context) {
    return BottomDrawer(
      header: _buildBottomDrawerHead(context),
      body: _buildBottomDrawerBody(context),
      headerHeight: _headerHeight,
      drawerHeight: _bodyHeight,
      color: Colors.grey,
      controller: _controller,
    );
  }

  Widget _buildBottomDrawerHead(BuildContext context) {
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
                // vm.confirmCart();
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
    return Container(
      height: _headerHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(Icons.drag_handle, color: Colors.white,),
            enterCartItemsText
          ],
        ),
      )
    );
  }

  Widget _buildBottomDrawerBody(BuildContext context){
    return Container(
      height: _bodyHeight,
    );
  }

}
