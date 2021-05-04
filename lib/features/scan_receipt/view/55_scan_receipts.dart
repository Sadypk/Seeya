import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/scan_receipt/theBoss/view/cameraView.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/features/store/view/widgets/top_picks_card_widget.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/custom_outline_button.dart';

class ScanReceipts extends StatefulWidget {
  @override
  _ScanReceiptsState createState() => _ScanReceiptsState();
}

class _ScanReceiptsState extends State<ScanReceipts> with SingleTickerProviderStateMixin{
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Receipts', style: AppConst.appbarTextStyle,),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TabBar(
                  controller: tabController,
                    indicatorColor: AppConst.themePurple,
                    labelStyle: AppConst.header2,
                    unselectedLabelStyle: AppConst.header2,
                    tabs: [
                      Tab(text: 'My favourite',),
                      Tab(text: 'Near me',),
                      // Text('My favourite', style: AppConst.header2,),
                      // Text('Near me', style: AppConst.header2,)
                    ]),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Text('Recently visited stores', style: AppConst.header2,),
                  ],
                ),
                Divider(height: 20,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        TopPicksCardWidget(storeModel: StoreModel(promotionCashback: 25, logo: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660'), height: 90, width: 100, fontSize: 8,),
                        SizedBox(height: 10,),
                        Text('Adidas', style: AppConst.header2 ,)
                      ],
                    ),
                    Column(
                      children: [
                        TopPicksCardWidget(storeModel: StoreModel(promotionCashback: 25, logo: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660'), height: 90, width: 100, fontSize: 8,),
                        SizedBox(height: 10,),
                        Text('Adidas', style: AppConst.header2 ,)
                      ],
                    ),
                    Column(
                      children: [
                        TopPicksCardWidget(storeModel: StoreModel(promotionCashback: 25, logo: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660'), height: 90, width: 100, fontSize: 8,),
                        SizedBox(height: 10,),
                        Text('Adidas', style: AppConst.header2 ,)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        TopPicksCardWidget(storeModel: StoreModel(promotionCashback: 25, logo: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660'), height: 90, width: 100, fontSize: 8,),
                        SizedBox(height: 10,),
                        Text('Adidas', style: AppConst.header2 ,)
                      ],
                    ),
                    Column(
                      children: [
                        TopPicksCardWidget(storeModel: StoreModel(promotionCashback: 25, logo: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660'), height: 90, width: 100, fontSize: 8,),
                        SizedBox(height: 10,),
                        Text('Adidas', style: AppConst.header2 ,)
                      ],
                    ),
                    Column(
                      children: [
                        TopPicksCardWidget(storeModel: StoreModel(promotionCashback: 25, logo: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660'), height: 90, width: 100, fontSize: 8,),
                        SizedBox(height: 10,),
                        Text('Adidas', style: AppConst.header2 ,)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomOutlineButton(
                      onTap: (){
                        Get.to(TheBossCameraScreen(storeModel: StoreModel(),));
                      },
                      label: 'View all offers',
                      height: 28,
                      width: 160,
                      fontStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Stag'),
                    )
                  ],
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Special offers made for you', style: AppConst.titleText1,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                          onTap: (){},
                          child: Text('View All', style: AppConst.descriptionTextPurple,)),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                DefaultTabController(
                  length: 5,
                  child: ButtonsTabBar(
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
                ),
                SizedBox(height: 15,),
              ],
            ),
          ),
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: 6,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          StoreShopNowTile2(label: 'Something',),
                          Divider(height: 40,)
                        ],
                      ));
            }),
          )
        ],
      ),
    );
  }
}
