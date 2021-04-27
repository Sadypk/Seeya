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
import 'package:seeya/newDataViewModel.dart';
import '44_favourite_grocery_stores.dart';

class StoresWithCategoryOffers extends StatefulWidget {
  final String title;

  const StoresWithCategoryOffers({Key key, this.title}) : super(key: key);
  @override
  _StoresWithCategoryOffersState createState() => _StoresWithCategoryOffersState();
}

class _StoresWithCategoryOffersState extends State<StoresWithCategoryOffers> {
  @override
  Widget build(BuildContext context) {
    var storeList = NearestStoreViewModel().storeList;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        titleSpacing: 0,
        title: Text('${widget.title} offers', style: AppConst.appbarTextStyle,),
        actions: [
          Icon(Icons.search, size: 20,),
          SizedBox(width: 20),
          Icon(FeatherIcons.mapPin, size: 16,),
          SizedBox(width: 20)
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
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
                            return SpecialOfferTile(
                              data: SpecialOfferTileData(
                                image: StringResources.demoImage,
                                label: 'label label',
                                title: 'title',
                                subtitle1: 'subtitle 1',
                                subtitle2: 'subtitle 2'
                              )
                            );
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
                  Get.to(FavouriteGroceryStores());
                },
                label: 'View all offers',
                height: 28,
                width: 160,
                fontStyle: TextStyle(fontSize: 12, fontFamily: 'Stag'),
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
