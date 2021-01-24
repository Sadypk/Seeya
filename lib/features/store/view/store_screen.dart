import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seeya/features/home_screen/view_models/top_products_view_model.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget.dart';
import 'package:seeya/features/store/view_model/cart_view_model.dart';
import 'package:seeya/main_app/models/product_model.dart';
import 'package:seeya/main_app/models/store_model.dart';
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
  double _headerHeight = 60.0;
  double _bodyHeight = 160.0;
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
          return ProductCardWidget(productModel: productList1[index],);
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
          title: Text(widget.storeModel.storeName, style: TextStyle(color: Colors.black54),),
          actions: [
            IconButton(icon: Icon(Icons.shopping_bag_outlined), onPressed: null),
            IconButton(icon: Icon(Icons.favorite_border), onPressed: null),
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
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: TabBarView(
                children: [
                  allTab,
                  allTab,
                  allTab,
                ],
              ),
            ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Items added to cart: '+vm.cartItems.length.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text('Proceed', style: TextStyle(color: vm.cartItems.length==0?Colors.grey:Colors.lightBlueAccent, fontWeight: FontWeight.bold),),
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

  Widget _buildBottomDrawerBody(BuildContext context) {
    CartViewModel vm = Get.find();

    return Obx((){
      return Container(
        width: double.infinity,
        height: _bodyHeight,
        padding: EdgeInsets.only(left: 10),
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
      );
    });
  }
}

