import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:seeya/features/home_screen/view/widgets/offer_list_tile.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';

class AllOffersNearYou extends StatefulWidget {
  @override
  _AllOffersNearYouState createState() => _AllOffersNearYouState();
}

class _AllOffersNearYouState extends State<AllOffersNearYou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All offers near your area', style: AppConst.appbarTextStyle,),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('We found ₹3000+ rewards for you', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 15,),
              DefaultTabController(
                length: 5,
                child: ButtonsTabBar(
                  backgroundColor: Colors.black54,
                  unselectedBackgroundColor: Colors.white,
                  unselectedLabelStyle: TextStyle(color: Colors.black),
                  radius: 20,
                  borderColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  borderWidth: 1,
                  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
              ),
              SizedBox(height: 25,),
              Expanded(
                child: ListView.builder(
                  itemCount: 15,
                    itemBuilder: (BuildContext context, int index){
                      return OfferListTile();
                    }
                )
              ),
              GradientButton(
                height: 40,
                label: 'Claim all Rewards',
                fontStyle: AppConst.titleText1White,
              )
            ],
          ),
        ),
      ),
    );
  }
}
