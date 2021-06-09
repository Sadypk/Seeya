import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:seeya/features/order_online/repo/my_special_offers.dart';
import 'package:seeya/features/order_online/view_model/special_offer.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/newMainAPIs.dart';

class NearMe extends StatefulWidget {

  @override
  _NearMeState createState() => _NearMeState();
}

class _NearMeState extends State<NearMe> {



  List<BoomModel> allStores = [];
  List<BoomModel> groceries = [];
  List<BoomModel> fresh = [];
  List<BoomModel> pharmacy = [];
  List<BoomModel> restaurant = [];

  bool dataLoad = true;
  getData() async{

    allStores.addAll(await MySpecialOffers.getMySpecialOffers());

    groceries.addAll(allStores.where((element) => element.businesstypeId == '5fde415692cc6c13f9e879fd'));
    fresh.addAll(allStores.where((element) => element.businesstypeId == '5fdf434058a42e05d4bc2044'));
    restaurant.addAll(allStores.where((element) => element.businesstypeId == '5fe0bfef4657be045655cf4a'));
    pharmacy.addAll(allStores.where((element) => element.businesstypeId == '5fe22e111df87913f06a4cc9'));

    setState(() {
      dataLoad = false;
    });
  }
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return dataLoad ? SpinKitDualRing(color: AppConst.themePurple) :DefaultTabController(
      length: 5,
      child: Column(
        children: [
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
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                text: "All",
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
          SizedBox(
            height: 15,
          ),
          Container(
            height: 500,
            child: TabBarView(
              children: [
                SpecialOffer(data: allStores),
                SpecialOffer(data: groceries),
                SpecialOffer(data: fresh),
                SpecialOffer(data: restaurant),
                SpecialOffer(data: pharmacy),
              ],
            ),
          ),
        ],
      ),
    );
  }
}