import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seeya/features/home_screen/view_models/top_products_view_model.dart';
import 'package:seeya/features/store/view/confirm_order_screen.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget.dart';
import 'package:seeya/features/store/view_model/cart_view_model.dart';
import 'package:seeya/main_app/models/product_model.dart';
import 'package:seeya/features/store/models/store_model.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:get/get.dart';


class StoreScreen extends StatefulWidget{
  final StoreModel storeModel;
  StoreScreen({this.storeModel});
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  //Bottom Drawer
  double _headerHeight = 200.0;
  double _bodyHeight = 300.0;
  BottomDrawerController _controller = BottomDrawerController();


  @override
  void initState() {
    Get.put(CartViewModel());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    var productList1 = TopProductsViewModel().productList;
    var allTab = Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: GridView.builder(
        itemCount: productList1.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: ((MediaQuery.of(context).size.width/2)/250),
          // crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index){
          CartViewModel vm = Get.find();
          return Obx((){
            return ProductCardWidget(
              productModel: productList1[index],
              iconButton: IconButton(icon: Icon(vm.cartItems.contains(productList1[index])?Icons.remove_circle_outline_rounded:Icons.add_circle_outline_rounded, color: Colors.red,), onPressed: (){
                if(vm.cartItems.contains(productList1[index])){
                  vm.cartItems.removeWhere((x) => x.productId == productList1[index].productId);
                }else{
                  vm.cartItems.add(productList1[index]);
                }
              }),
            );
          });
        },
      ),
    );

    CartViewModel vm = Get.find();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black54
          ),
          title: Text(widget.storeModel.storeName, style: TextStyle(color: Colors.black54),),
          actions: [
            IconButton(icon: Icon(Icons.camera_alt_outlined ), onPressed: null),
            Obx((){
              return IconButton(icon: Icon((vm.cartManualItems.length+vm.cartItems.length)>0?Icons.shopping_bag:Icons.shopping_bag_outlined, color: (vm.cartManualItems.length+vm.cartItems.length)>0?Colors.red:Colors.black54,), onPressed: (){
                if((vm.cartManualItems.length+vm.cartItems.length)>0){
                  vm.confirmCart();
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
        height: _headerHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.drag_handle, color: Colors.white,),
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

  Widget _buildBottomDrawerBody(BuildContext context) {
    CartViewModel vm = Get.find();

    return Obx((){
      return Container(
        width: double.infinity,
        height: _bodyHeight,
        padding: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: vm.cartItems.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      height: 60,
                      width: 60,
                      margin: EdgeInsets.only(right: 10, top: 10),
                      child: Stack(
                        overflow: Overflow.visible,
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
                              child: Image.network(vm.cartItems[index].productImage, fit: BoxFit.cover,),
                            ),
                          ),
                          Positioned(
                            top: -5,
                            right: -5,
                            child: InkWell(
                              onTap: (){
                                // print('trying to remove');
                                vm.cartItems.removeWhere((v) => v==vm.cartItems[index]);
                              },
                              child: Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: FaIcon(FontAwesomeIcons.solidTimesCircle, color: Colors.red, size: 14,),
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
              ),
            )
          ],
        ),
      );
    });
  }
}

