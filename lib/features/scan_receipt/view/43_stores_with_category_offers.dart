import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/store/view/widgets/special_offer_tile.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/custom_outline_button.dart';

class StoresWithCategoryOffers extends StatefulWidget {
  @override
  _StoresWithCategoryOffersState createState() => _StoresWithCategoryOffersState();
}

class _StoresWithCategoryOffersState extends State<StoresWithCategoryOffers> {
  @override
  Widget build(BuildContext context) {
    var storeList = NearestStoreViewModel().storeList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan vegetable offers', style: AppConst.appbarTextStyle,),
      ),
      body: ListView(
        children: [
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
                      height: 300,
                      child: ListView.builder(
                          itemCount: 6,
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
          CustomOutlineButton(
            label: 'View all offers',
            height: 28,
            width: 160,
            fontStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Stag'),
          )
        ],
      ),
    );
  }
}
