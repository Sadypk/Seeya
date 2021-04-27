import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:seeya/features/chat/model/ddModel.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/scan_receipt/view/41_scan_specific_receipts.dart';
import 'package:seeya/features/store/view/widgets/special_offer_tile.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/resources/string_resources.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';
import 'package:seeya/newDataViewModel.dart';

import '44_favourite_grocery_stores.dart';

class FavStoresMainPage extends StatefulWidget {
  @override
  _FavStoresMainPageState createState() => _FavStoresMainPageState();
}

class _FavStoresMainPageState extends State<FavStoresMainPage> {

  Widget customTile(String label, int count){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleImageWidget(image: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660',),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 22, fontFamily: 'Stag', ),),
                SizedBox(height: 3),
                Text('Upto 35% Cashback', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'open', color: Color(0xffEE1717)),)
              ],
            )
          ],
        ),
        Container(
          height: 32,
          width: 50,
          // padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.3, 1),
                  color: Colors.grey[300],
                  blurRadius: 5,
                  spreadRadius: 2
              )
            ],
          ),
          child: Center(
            child: Text("$count", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: AppConst.themePurple, fontFamily: 'Stag'),),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async{
    
  }

  @override
  Widget build(BuildContext context) {
    var storeList = NearestStoreViewModel().storeList;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Favourite shops', style: AppConst.appbarTextStyle,),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Icon(Icons.search, size: 20,),
          SizedBox(width: 20),
          Icon(FeatherIcons.mapPin, size: 16,),
          SizedBox(width: 20)
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20,),
            InkWell(
                onTap: (){
                  Get.to(()=>FavouriteGroceryStores(title: 'Grocery'));
                },
                child: customTile('Grocery', 58)),
            Divider(color: Colors.grey[200], thickness: 1, height: 20,),
            customTile('Fresh Items', 37),
            Divider(color: Colors.grey[200], thickness: 1, height: 20,),
            customTile('Pharmacy', 26),
            Divider(color: Colors.grey[200], thickness: 1, height: 20,),
            customTile('Restaurant', 32),
            Divider(color: Colors.grey[200], thickness: 1, height: 20,),
            SizedBox(height: 15,),
            Expanded(
              child : DefaultTabController(
                  length: 5,
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
                      Expanded(
                        child: ListView.builder(
                            itemCount: 20,
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
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
