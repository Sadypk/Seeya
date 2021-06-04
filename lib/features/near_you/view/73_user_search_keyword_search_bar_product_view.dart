import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/near_you/view/75_user_search_page_result_not_found.dart';
import 'package:seeya/main_app/resources/app_const.dart';

class UserSearchKeywordSearchBarProductView extends StatefulWidget {
  @override
  _UserSearchKeywordSearchBarProductViewState createState() => _UserSearchKeywordSearchBarProductViewState();
}

class _UserSearchKeywordSearchBarProductViewState extends State<UserSearchKeywordSearchBarProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff666666)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Color(0xff252525).withOpacity(0.4)),
                color: Colors.white
            ),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Icon(Icons.search, color: AppConst.black.withOpacity(0.7),)),
                Flexible(child: TextFormField(
                  // controller: searchController,
                  decoration: InputDecoration(
                      hintText: 'Chicken biriyani',
                      hintStyle: TextStyle(fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'open',
                      color: AppConst.black.withOpacity(0.7)),
                      suffixIcon: Icon(FeatherIcons.x)
                  ),
                ))
              ],
            ),
          ),
          SizedBox(height: 15,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: DefaultTabController(length: 2,
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
                      text: "Stores",
                    ),
                    Tab(
                      text: "Products",
                    ),
                  ],
                )),
          ),
          SizedBox(height: 20,),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Special offer made for you', style: AppConst.header2,)),
          SizedBox(height: 15,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: DefaultTabController(length: 5,
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
                )),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index){
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      if(index==0)Divider(height: 20, color: Color(0xff252525).withOpacity(0.4),),
                      InkWell(
                          onTap:(){Get.to(UserSearchPageResultNotFound());},
                          child: StoreShopNowTile3(label: 'Something',)),
                      Divider(height: 20, color: Color(0xff252525).withOpacity(0.4),),
                    ],
                  ),
                );
              }
              ),
          )
        ],
      ),
    );
  }
}
