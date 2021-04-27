import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/store/view/widgets/special_offer_tile.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/resources/string_resources.dart';
import 'package:seeya/main_app/view/widgets/custom_outline_button.dart';
import 'package:seeya/main_app/view/widgets/square_image_widget.dart';
import 'package:seeya/newDataViewModel.dart';
import '43_stores_with_category_offers.dart';
import '45_fav_stores_main_page.dart';
import 'package:seeya/main_app/models/45_model.dart';

class FavouriteGroceryStores extends StatefulWidget {
  final String title;
  final List<StoreModel> stores;
  final List<ProductModel> products;

  const FavouriteGroceryStores({Key key,@required this.title,@required this.stores,@required this.products}) : super(key: key);
  @override
  _FavouriteGroceryStoresState createState() => _FavouriteGroceryStoresState();
}

class _FavouriteGroceryStoresState extends State<FavouriteGroceryStores> {
  @override
  Widget build(BuildContext context) {
    var storeList = NearestStoreViewModel().storeList;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        titleSpacing: 0,
        title: Text('Favourite ${widget.title} stores', style: AppConst.appbarTextStyle,),
        actions: [
          Icon(Icons.search, size: 20,),
          SizedBox(width: 20),
          Icon(FeatherIcons.mapPin, size: 16,),
          SizedBox(width: 20)
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            margin: EdgeInsets.only(left: 20),
            child: ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    onTap: (){
                      Get.to(()=>StoresWithCategoryOffers(title: 'Demo'));
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 16, top: 25, bottom: 25),
                        child: SquareImageWidget(
                          title: 'Demo',
                          image: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660',)),
                  );
                }),
          ),
          DefaultTabController(
              length: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Special offers made for you', style: AppConst.titleText1,),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 10),
                        //   child: Text('View All', style: AppConst.descriptionTextPurple,),
                        // ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    ButtonsTabBar(
                      backgroundColor: Color(0xff252525),
                      unselectedBackgroundColor: Colors.white,
                      unselectedLabelStyle: TextStyle(color: Color(0xff252525)),
                      radius: 20,
                      borderColor: Color(0xff707070),
                      unselectedBorderColor: Color(0xff707070),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      borderWidth: 1,
                      labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          text: "Recent",
                        ),
                        Tab(
                          text: "Grocery",
                        ),
                        Tab(
                          text: "Fresh",
                        ),
                        Tab(
                          text: "Restaurant",
                        ),
                        Tab(
                          text: "Pharmacy",
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 200,
                      child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index){
                            return SpecialOfferTile(data: SpecialOfferTileData(
                              image: StringResources.demoImage,
                              title: 'title',
                              subtitle1: '123',
                              subtitle2: '123',
                              label: '123'
                            ));
                          }
                      ),
                    )
                  ],
                ),
              )
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomOutlineButton(
                onTap: (){
                  Get.to(FavStoresMainPage());
                },
                label: 'View all offers',
                height: 28,
                width: 160,
                fontStyle: TextStyle(fontSize: 12,fontFamily: 'Stag'),
              )
            ],
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('All restaurants near you', style: AppConst.header2,),
                Row(
                  children: [
                    Text('Sort by', style: AppConst.descriptionText,),
                    Icon(Icons.keyboard_arrow_down_outlined, size: 18, color: Colors.black87,)
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 20,),
          ),
          Container(
            child: Expanded(
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            StoreShopNowTile(label: 'Adidas'),
                            Divider(height: 20,)
                          ],
                        ),
                      );
                    }
                )
            ),
          )
        ],
      ),
    );
  }
}
