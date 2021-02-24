import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/home_screen/view_models/top_products_view_model.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/features/store/view/store_screen.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget.dart';
import 'package:seeya/features/store/view/widgets/store_tile_widget.dart';
import 'package:seeya/features/store/view_model/cart_view_model.dart';
import 'package:seeya/main_app/resources/string_resources.dart';

class OnlineOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CartViewModel());
    var storeList = NearestStoreViewModel().storeList;
    var storesTabBarView = Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index){
          return StoreTileWidget(storeModel: storeList[index], onTap: (){Get.to(StoreScreen(storeModel: storeList[index],));},);
        },
        itemCount: storeList.length,
      ),
    );





    var productList = TopProductsViewModel().productList;
    var productsTabBarView = DefaultTabController(
        length: 5, child: Scaffold(
        body: Column(
        children: [
          SizedBox(height: 5,),
          ButtonsTabBar(
            backgroundColor: Colors.green,
            unselectedBackgroundColor: Colors.grey[300],
            unselectedLabelStyle: TextStyle(color: Colors.black),
            labelStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                icon: FaIcon(FontAwesomeIcons.circle),
                text: "All",
              ),
              Tab(
                icon: FaIcon(FontAwesomeIcons.carrot),
                text: "Vegetables",
              ),
              Tab(
                icon: FaIcon(FontAwesomeIcons.pepperHot),
                text: "Spices",
              ),
              Tab(
                icon: FaIcon(FontAwesomeIcons.appleAlt),
                text: "Fruits",
              ),
              Tab(
                icon: FaIcon(FontAwesomeIcons.book),
                text: "Books",
              ),
            ],
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: productList.length,
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
                    productModel: productList[index],
                    iconButton: IconButton(icon: Icon(vm.cartItems.contains(productList[index])?Icons.remove_circle_outline_rounded:Icons.add_circle_outline_rounded, color: Colors.red,), onPressed: (){
                      Get.to(StoreScreen(storeModel: StoreModel(name: 'Test'),));
                    }),
                  );
                });
              },
            ),
          )
        ],
      ),
    ));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue,
          title: Text(StringResources.onlineOrdersAppbarTitleText),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Stores',),
              Tab(text: 'Products',),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            storesTabBarView,
            productsTabBarView
          ],
        ),
      ),
    );
  }
}
