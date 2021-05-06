import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:seeya/features/online_orders/view/online_orders_screen.dart';
import 'package:seeya/features/redeem_balance/view/redeem_balance.dart';
import 'package:seeya/features/scan_receipt/view/55_scan_receipts.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/util/size_config.dart';
import 'package:seeya/main_app/util/screenLoader.dart';

import 'features/home_screen/view/home_screen.dart';
import 'features/my_offers_screen/view/my_offers_screen.dart';
import 'features/profile_screen/view/profile_screen.dart';
import 'features/search_screen/view/search_screen.dart';
import 'features/wallet/view/68_my_wallet.dart';
import 'main_app/util/over_scroll.dart';

class Home extends StatefulWidget {
  static RxBool loading = false.obs;
  static changeLoading() => loading.value = !loading.value;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Bottom Navigation Bar
  int bottomIndex = 0 ;
  final _screens = [
    HomeScreen(),
    SearchScreen(),
    MyWalletScreen(),
    ProfileScreen()
  ];
  final _icons = [
    Icons.home,
    CupertinoIcons.cube_box,
    CupertinoIcons.gift,
    CupertinoIcons.person
  ];


  //Widget size configuration
  GetSizeConfig getSizeConfig;
  @override
  void initState() {
    getSizeConfig = Get.find();
    super.initState();
  }
  h(double v){return getSizeConfig.height.value*v;}
  w(double v){return getSizeConfig.width.value*v;}

  bottomNavBarItem(int index, IconData iconData, String label){
    return InkWell(
      onTap: (){
        setState(() {
          bottomIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width/5,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, color: index==bottomIndex?Colors.purpleAccent:Colors.grey[400],),
              Text(label, style: TextStyle(color: index==bottomIndex?Colors.purpleAccent:Colors.grey[400]),)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var customBottomNavBar = Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0,-1),
            color: Colors.grey[200],
            spreadRadius: 1,
            blurRadius: 1
          )
        ]
      ),
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bottomNavBarItem(0, Icons.home_outlined, 'Home'),
          bottomNavBarItem(1, Icons.search, 'Near'),
          InkWell(
            onTap: () {
              Get.bottomSheet(
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12)),
                        boxShadow: [AppConst.shadowBottomNavBar]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12))
                          ),
                          elevation: 0,
                          child: Container(
                            width: double.infinity,
                            height: h(150),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    Text(
                                      'Choose an option',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          fontFamily: 'Stag',
                                          color: Color(0xff252525)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.times, size: 16,),
                                    SizedBox(width: 20,)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: OverScroll(
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              children: [
                                ListTile(
                                  onTap: (){
                                    Get.back();
                                    Get.to(ScanReceipts());
                                  },
                                  title: Text('Scan Receipt', style: TextStyle(fontFamily: 'open', fontSize: 14, fontWeight: FontWeight.w600),),
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        AppConst.shadowBasic
                                      ],
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xff707070), width: 0.01)
                                    ),
                                    child: Center(
                                      child: Image.asset('assets/images/plus-button-1.png'),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  onTap: (){
                                    Get.back();
                                    Get.to(OnlineOrdersScreen());
                                  },
                                  title: Text('Order Online', style: TextStyle(fontFamily: 'open', fontSize: 14, fontWeight: FontWeight.w600),),
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          AppConst.shadowBasic
                                        ],
                                        color: Colors.white,
                                        border: Border.all(color: Color(0xff707070), width: 0.01)
                                    ),
                                    child: Center(
                                      child: Image.asset('assets/images/plus-button-2.png'),
                                    ),
                                  )
                                ),
                                ListTile(
                                  onTap: (){
                                    Get.back();
                                    Get.to(RedeemBalanceScreen());
                                  },
                                  title: Text('Redeem Cash', style: TextStyle(fontFamily: 'open', fontSize: 14, fontWeight: FontWeight.w600),),
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          AppConst.shadowBasic
                                        ],
                                        color: Colors.white,
                                        border: Border.all(color: Color(0xff707070), width: 0.01)
                                    ),
                                    child: Center(
                                      child: Image.asset('assets/images/plus-button-3.png'),
                                    ),
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: h(20),)
                      ],
                    ),
                  )
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width/5,
              child: Center(
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black54, width: 3)
                  ),
                  child: Center(child: Icon(Icons.add, color: Colors.black54,))),
              ),
            ),
          ),
          bottomNavBarItem(2, Icons.account_balance_wallet_rounded, 'Wallet'),
          bottomNavBarItem(3, FontAwesomeIcons.userCircle, 'Profile'),
        ],
      ),
    );
    return Obx(()=>IsScreenLoading(
      screenLoading: Home.loading.value,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // bottomNavigationBar: AnimatedBottomNavigationBar(
        //     icons: _icons,
        //     activeIndex: bottomIndex,
        //     gapLocation: GapLocation.center,
        //     backgroundColor: Colors.white,
        //     activeColor: AppConst.themeBlue,
        //     inactiveColor: Colors.black,
        //     notchSmoothness: NotchSmoothness.softEdge,
        //     leftCornerRadius: w(30),
        //     rightCornerRadius: w(30),
        //     iconSize: h(70),
        //     onTap: (index){
        //       setState(() {
        //         bottomIndex = index;
        //       });
        //     }
        //   //other params
        // ),
        body: Stack(
          children: [
            IndexedStack(
              children: _screens,
              index: bottomIndex,
            ),
            Positioned(
                bottom: 0,
                child: customBottomNavBar
            ),
          ],
        ),
      ),
    ));
  }
}
