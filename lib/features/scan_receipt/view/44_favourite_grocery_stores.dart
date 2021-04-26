import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/store/view/widgets/special_offer_tile.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/custom_outline_button.dart';
import 'package:seeya/main_app/view/widgets/square_image_widget.dart';
import '45_fav_stores_main_page.dart';

class FavouriteGroceryStores extends StatefulWidget {
  @override
  _FavouriteGroceryStoresState createState() => _FavouriteGroceryStoresState();
}

class _FavouriteGroceryStoresState extends State<FavouriteGroceryStores> {
  @override
  Widget build(BuildContext context) {
    var storeList = NearestStoreViewModel().storeList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan vegetable offers', style: AppConst.appbarTextStyle,),
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

                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 16, top: 25, bottom: 25),
                        child: SquareImageWidget(image: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660',)),
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
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text('View All', style: AppConst.descriptionTextPurple,),
                        ),
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
                            return SpecialOfferTile(storeModel: storeList[0],);
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
                fontStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Stag'),
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