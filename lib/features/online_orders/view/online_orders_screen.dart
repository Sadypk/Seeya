import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/home_screen/view_models/top_products_view_model.dart';
import 'package:seeya/features/store/models/store_model.dart';
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
          return StoreTileWidget(storeModel: storeList[index],);
        },
        itemCount: storeList.length,
      ),
    );





    var productList = TopProductsViewModel().productList;
    var productsTabBarView = DefaultTabController(length: 3, child: Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.green,
            child: TabBar(
              tabs: [
                Tab(text: 'All',),
                Tab(text: 'Groceries',),
                Tab(text: 'What\'s new',),
              ],
            ),
          ),
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
                return ProductCardWidget(productModel: productList[index], goToStoreScreen:  true,);
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
          title: Text(StringResources.storeRedeemSelectListText),
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
