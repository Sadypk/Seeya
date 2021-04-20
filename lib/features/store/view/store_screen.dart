
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seeya/features/home_screen/view_models/top_products_view_model.dart';
import 'package:seeya/features/scan_receipt/theBoss/view/cameraView.dart';
import 'package:seeya/features/store/models/cart_model.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/features/store/view/confirm_order_screen.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget_old.dart';
import 'package:seeya/features/store/view_model/cart_view_model.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:get/get.dart';


class StoreScreen extends StatelessWidget {
  final StoreModel storeModel;
  StoreScreen({this.storeModel});


  @override
  Widget build(BuildContext context) {
    Get.put(CartViewModel());
    var productList1 = TopProductsViewModel().productList;
    CartViewModel vm = Get.find();
    productList1.forEach((v){
      vm.cartItemsWithQuantity.add(CartModel(product: v, count: 0));
    });

    var allTab = Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: GridView.builder(
        itemCount: productList1.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.95/1,
          // crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index){
          return Obx((){
            return ProductCardWidget(
              productModel: productList1[index],
              iconButton: IconButton(icon: Icon(vm.cartItems.contains(productList1[index])?FontAwesomeIcons.checkCircle:Icons.add_circle_outline_rounded, color: vm.cartItems.contains(productList1[index])?Colors.green:Colors.red,), onPressed: (){
                vm.cartItemsWithQuantity.add(CartModel(
                    count: 0),
                );
                if(!vm.cartItems.contains(productList1[index])){
                  vm.cartItems.add(productList1[index]);
                  vm.cartItemsWithQuantity[index].count++;
                }
                // if(vm.cartItems.contains(productList1[index])){
                //   vm.cartItems.removeWhere((x) => x.productId == productList1[index].productId);
                // }else{
                //   vm.cartItems.add(productList1[index]);
                // }
              }),
              quantityController: vm.cartItems.contains(productList1[index])?Container(
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: (){
                          vm.cartItemsWithQuantity[index].count--;
                          vm.cartItemsWithQuantity.add(CartModel(count: 0));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(3), bottomLeft: Radius.circular(3))
                          ),
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Icon(Icons.remove, color: Colors.white, size: 12,),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text(vm.cartItemsWithQuantity[index].count.toString(), style: TextStyle(color: Colors.white, fontSize: 12),),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: (){
                          vm.cartItemsWithQuantity[index].count++;
                          print(vm.cartItemsWithQuantity[index].count);
                          vm.cartItemsWithQuantity.add(CartModel(count: 0));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(3), bottomRight: Radius.circular(3))
                          ),
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Icon(Icons.add, color: Colors.white, size: 12,),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ):SizedBox(),
            );
          });
        },
      ),
    );


    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black54
          ),
          title: Text(storeModel.name, style: TextStyle(color: Colors.black54),),
          actions: [
            IconButton(icon: Icon(Icons.camera_alt_outlined ), onPressed: (){
              /// modding
              Get.to(()=>TheBossCameraScreen());
              // Get.to(ScanReceiptScreen());
            }),
            Obx((){
              var list = <CartModel>[].obs;
              vm.cartItemsWithQuantity.forEach((v) {
                if(v.product != null)list.add(v);
              });
              return IconButton(icon: Icon((vm.cartManualItemsWithQuantity.length+vm.cartItems.length)>0?Icons.shopping_bag:Icons.shopping_bag_outlined, color: (vm.cartManualItemsWithQuantity.length+vm.cartItems.length)>0?Colors.red:Colors.black54,), onPressed: (){
                if((vm.cartManualItemsWithQuantity.length+vm.cartItems.length)>0){
                  // vm.confirmCart();
                  vm.cartItemsWithQuantity.clear();
                  vm.cartItemsWithQuantity.addAll(list);
                  Get.to(ConfirmOrderScreen());
                }
              },);
            }),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            // labelColor: Colors.blue,
            indicatorColor: Colors.green,
            tabs: [
              Tab(child: Text('All', style: TextStyle(color: Colors.black),),),
              Tab(child: Text('Groceries',style: TextStyle(color: Colors.black),),),
              Tab(child: Text('Fruits & Vegetables', style: TextStyle(color: Colors.black),),),
            ],
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 110),
              child: TabBarView(
                children: [
                  allTab,
                  allTab,
                  allTab,
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: enterCartItemsText,
            // ),
            _buildBottomDrawer(context)
          ],
        ),
      ),
    );
  }

  //Bottom Drawer
  double _headerHeight = 200.0;
  double _bodyHeight = 300.0;
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
              }
              cartTextController.clear();
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(3)
              ),
              child: Center(
                child: Text('Add to cart', style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold),),
              ),
            ),
          )
        ],
      ),
    );
    CartViewModel vm = Get.find();
    return Obx((){
      return Container(
        height: _headerHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.keyboard_arrow_up_outlined, color: Colors.white,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Items added to cart: '+(vm.cartItems.length+vm.cartManualItemsWithQuantity.length).toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
                    itemCount: vm.cartManualItemsWithQuantity.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index){
                      return InkWell(
                        onTap: (){
                          vm.cartManualItemsWithQuantity.removeWhere((x) => x.product == vm.cartManualItemsWithQuantity[index].product);
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
                              Text(vm.cartManualItemsWithQuantity[index].product.productName, style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),),
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

  Widget _buildBottomDrawerBody(BuildContext context) {
    Get.put(CartViewModel());
    CartViewModel vm = Get.find();

    return Container(
      width: double.infinity,
      height: _bodyHeight,
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Obx((){
              return ListView.builder(
                  itemCount: vm.cartItemsWithQuantity.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return vm.cartItemsWithQuantity[index].count>0?Container(
                      height: 60,
                      width: 60,
                      margin: EdgeInsets.only(right: 10, top: 10),
                      child: Stack(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.white, width: 1)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(vm.cartItemsWithQuantity[index].product.productImage, fit: BoxFit.cover,),
                            ),
                          ),
                          Positioned(
                            top: -5,
                            right: -5,
                            child: Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text('${vm.cartItemsWithQuantity[index].count}', style: TextStyle(fontWeight:FontWeight.bold, color: Colors.red),),
                                )
                            ),
                          )
                        ],
                      ),
                    ):SizedBox();
                  }
              );
            }),
          )
        ],
      ),
    );
  }
}


