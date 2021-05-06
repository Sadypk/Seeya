import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/store/view/46_nearest_stores_main_page.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import '69_wallet_information.dart';

class MyWalletScreen extends StatefulWidget {
  @override
  _MyWalletScreenState createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  @override
  Widget build(BuildContext context) {
    rewardCard(String image, String desc, String title, Color color){
      return InkWell(
        onTap: (){
          Get.to(WalletInformation());
        },
        child: Container(
          height: 80,
          width: 100,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                ),
                child: Center(
                  child: Image.asset(image),
                ),
              ),
              SizedBox(height: 10,),
              Text(desc, style: TextStyle(fontSize: 7, color: Color(0xffEBEBEB), fontFamily: 'Stag'),),
              Text(title, style: TextStyle(fontSize: 9, fontFamily: 'Stag', color: Colors.white),)
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My wallet', style: AppConst.appbarTextStyle,),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My rewards', style: AppConst.titleText1,),
                Text('View all', style: TextStyle(fontSize: 10, color: AppConst.themePurple, fontWeight: FontWeight.w600, fontFamily: 'open'),),
              ],
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                rewardCard('assets/images/reward_icon_1.png', '-  Shop 500₹  -', 'Get free delivery', Color(0xff4A3980)),
                rewardCard('assets/images/reward_icon_2.png', '-  Free offer  -', 'Buy 2 Get 1 Free', Color(0xffD235CE)),
                rewardCard('assets/images/reward_icon_3.png', '-  Deals for Two  -', 'Get Upto 200₹ Off', Color(0xffFF6C7A)),
              ],
            ),
          ),
          SizedBox(height: 30,),
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
                          child: InkWell(
                              onTap: (){
                                Get.to(NearestStoresMainPage());
                              },
                              child: Text('View All', style: AppConst.descriptionTextPurple,)),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    ButtonsTabBar(
                      physics: AlwaysScrollableScrollPhysics(),
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
                      height: 500,
                      child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index){
                            return Column(
                              children: [
                                if(index==0)Divider(height: 20,),
                                StoreShopNowTile2(label: 'Something',),
                                Divider(height: 20,)
                              ],
                            );
                          }),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
