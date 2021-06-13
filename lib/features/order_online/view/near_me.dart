import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:seeya/features/order_online/view_model/special_offer.dart';
import 'package:seeya/newMainAPIs.dart';

class NearMe extends StatefulWidget {
  final List<StoreData> allNearStores ;
  NearMe({@required this.allNearStores});
  @override
  _NearMeState createState() => _NearMeState();
}

class _NearMeState extends State<NearMe> {

  List<StoreData> allNearStores = [];
  List<StoreData> groceries = [];
  List<StoreData> fresh = [];
  List<StoreData> pharmacy = [];
  List<StoreData> restaurant = [];

  getData() async{

    allNearStores.addAll(widget.allNearStores);

    groceries.addAll(allNearStores.where((element) => element.businesstypeId == '5fde415692cc6c13f9e879fd'));
    fresh.addAll(allNearStores.where((element) => element.businesstypeId == '5fdf434058a42e05d4bc2044'));
    restaurant.addAll(allNearStores.where((element) => element.businesstypeId == '5fe0bfef4657be045655cf4a'));
    pharmacy.addAll(allNearStores.where((element) => element.businesstypeId == '5fe22e111df87913f06a4cc9'));
  }
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SingleChildScrollView(
        primary: false,
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
                  SpecialOffer(data: allNearStores),
                  SpecialOffer(data: groceries),
                  SpecialOffer(data: fresh),
                  SpecialOffer(data: restaurant),
                  SpecialOffer(data: pharmacy),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
