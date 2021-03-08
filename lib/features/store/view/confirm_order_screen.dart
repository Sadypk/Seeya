import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:seeya/features/store/models/cart_model.dart';
import 'package:seeya/features/store/view_model/cart_view_model.dart';
import 'package:seeya/home.dart';
import 'package:seeya/main_app/models/product_model.dart';

class ConfirmOrderScreen extends StatelessWidget {
  var check = false.obs;
  static var editAddress = false.obs;
  var address = 'Virat Nagar'.obs;
  @override
  Widget build(BuildContext context) {
    Get.put(CartViewModel());
    CartViewModel vm = Get.find();
    // vm.cartItemsWithQuantity.removeWhere((v) => v.count == 0);

    itemQuantityControllerTile(int i, bool manual){
      CartViewModel vm = Get.find();
      return (manual?vm.cartManualItemsWithQuantity[i].product:vm.cartItemsWithQuantity[i].product)!=null?Obx((){
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
                          if(vm.cartManualItemsWithQuantity[i].count>1){
                            vm.cartManualItemsWithQuantity[i].count--;
                            vm.cartManualItemsWithQuantity.add(CartModel(count: 0));
                            print(vm.cartManualItemsWithQuantity[i].count);
                          }
                        }else{
                          if(vm.cartItemsWithQuantity[i].count>1){
                            vm.cartItemsWithQuantity[i].count--;
                            vm.cartItemsWithQuantity.add(CartModel(count: 0));
                            print(vm.cartItemsWithQuantity[i].count);
                          }
                        }
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.blue)
                        ),
                        child: Center(
                          child: Icon(Icons.remove, color: (manual?vm.cartManualItemsWithQuantity[i].count:vm.cartItemsWithQuantity[i].count)>1?Colors.blueAccent:Colors.grey, size: 14,),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.blue)
                      ),
                      child: Center(
                        child: Text('${manual?vm.cartManualItemsWithQuantity[i] .count:vm.cartItemsWithQuantity[i].count}', style: TextStyle(color: Colors.blueAccent),),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        if(manual){
                          vm.cartManualItemsWithQuantity[i].count++;
                          vm.cartManualItemsWithQuantity.add(CartModel(count: 0));
                          print(vm.cartManualItemsWithQuantity[i].count);
                        }else{
                          vm.cartItemsWithQuantity[i].count++;
                          vm.cartItemsWithQuantity.add(CartModel(count: 0));
                          print(vm.cartItemsWithQuantity[i].count);
                        }
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.blue)
                        ),
                        child: Center(
                          child: Icon(Icons.add, color: Colors.blueAccent, size: 14,),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }):SizedBox();
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

    TextEditingController editAddressController = TextEditingController(text: address.value);
    var editAddressTextField = Obx((){
      return Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(3)
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
                flex: 3,
                child: Container(child: Text('Deliver to: ', style: TextStyle(fontWeight: FontWeight.bold),))),
            Flexible(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: editAddress.value?Colors.white:Colors.grey[200],
                  borderRadius: BorderRadius.circular(5)
                ),
                child: TextField(
                  controller: editAddressController,
                  onChanged: (v){address.value = v;},
                  enabled: editAddress.value,
                  decoration: InputDecoration.collapsed(hintText: null),
                ),
              ),
            ),
            // SizedBox(width: 10,),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: (){
                  editAddress.value = !editAddress.value;
                },
                child: Icon(editAddress.value?Icons.done:Icons.edit,size: 20, color: editAddress.value?Colors.green:Colors.grey,)),
            )
          ],
        ),
      );
    });


    _showExitDialog(context){
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return AlertDialog(
            title: Text('Cancel order?'),
            // content: SingleChildScrollView(
            //   child: ListBody(
            //     children: <Widget>[
            //       Text('This is a demo alert dialog.'),
            //       Text('Would you like to approve of this message?'),
            //     ],
            //   ),
            // ),
            actions: <Widget>[
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  vm.clearEmptyModels();
                  Get.offAll(Home());
                },
              ),
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      );
    }
    return WillPopScope(
      onWillPop: ()async{
        _showExitDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Confirm Order', style: TextStyle(color: Colors.black87),),
          actions: [
            FlatButton(
              color: Colors.cyanAccent,
              onPressed: () {

              },
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
                      Obx((){return Checkbox(value: check.value, onChanged: (v){check.value = v;});}),
                      Expanded(child: Text('Message me if any items is missed or replaced items.'))
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
                  Expanded(
                    child: ListView(
                      children: cartList()+cartManualList()+[SizedBox(height: 120,)],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: Get.height-250,
              bottom: 0,
              left: 0,
              right: 0,
              child: FlatButton(onPressed: null, child: Container(
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 60),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: Text('Submit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ))
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
