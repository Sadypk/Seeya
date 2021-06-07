import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/store/view/widgets/special_offer_tile.dart';
import 'package:seeya/main_app/models/45_model.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/resources/string_resources.dart';
import 'package:seeya/main_app/view/widgets/custom_outline_button.dart';
import '44_favourite_grocery_stores.dart';

class StoresWithCategoryOffers extends StatefulWidget {
  final String title;
  final List<StoreModel> stores;
  const StoresWithCategoryOffers({Key key,@required this.title ,@required this.stores}) : super(key: key);
  @override
  _StoresWithCategoryOffersState createState() => _StoresWithCategoryOffersState();
}

class _StoresWithCategoryOffersState extends State<StoresWithCategoryOffers> {
  List<StoreModel> stores = [];
  String filterValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stores = widget.stores;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        titleSpacing: 0,
        title: Text('${widget.title} offers', style: AppConst.appbarTextStyle,),
        actions: [
          Icon(Icons.search, size: 20,),
          SizedBox(width: 20),
          Icon(FeatherIcons.mapPin, size: 16,),
          SizedBox(width: 20)
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          DefaultTabController(
              length: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Special offers made for you', style: AppConst.titleText1,),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 10),
                        //   child: Text('View All', style: AppConst.descriptionTextPurple,),
                        // ),
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
                          text: "All",
                        ),
                        Tab(
                          text: "Cashback",
                        ),
                        Tab(
                          text: "Welcome offer",
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 200,
                      child: TabBarView(
                        children: [
                          PewPew(data: SpecialOfferTileData.parsedList(widget.stores)),
                          PewPew(data: SpecialOfferTileData.parsedList(widget.stores.where((element) => element.defaultCashback > 0 || element.promotionCashbackStatus == 'active' && element.promotionCashbackDate.startDate.isBefore(DateTime.now()) && element.promotionCashbackDate.endDate.isAfter(DateTime.now())))),
                          PewPew(data: SpecialOfferTileData.parsedList(widget.stores.where((element) => element.defaultWelcomeOffer > 0 || element.promotionWelcomeOfferStatus == 'active' && element.promotionWelcomeOfferDate.startDate.isBefore(DateTime.now()) && element.promotionWelcomeOfferDate.endDate.isAfter(DateTime.now())))),
                        ],
                      ),
                    )
                  ],
                ),
              )
          ),
          SizedBox(height: 15,),
          if(widget.stores.length > 6 )Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomOutlineButton(
                onTap: (){
                  // Get.to(FavouriteGroceryStores());
                },
                label: 'View all offers',
                height: 28,
                width: 160,
                fontStyle: TextStyle(fontSize: 12, fontFamily: 'Stag'),
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
            DropdownButtonHideUnderline(
              child: DropdownButton(
                isDense: true,
                hint: Text('Sort by', style: AppConst.descriptionText,),
                value: filterValue,
                onChanged: (String value){
                  setState(() {
                    filterValue = value;
                  });
                  if(filterValue == 'lowToHigh'){
                    setState(() {
                      stores.sort((a,b) => a.defaultCashback.compareTo(b.defaultCashback));
                    });
                  }else if(filterValue == 'highToLow'){
                    setState(() {
                      stores.sort((b,a) => a.defaultCashback.compareTo(b.defaultCashback));
                    });
                  }
                },
                items: [
                  DropdownMenuItem(
                    value: 'lowToHigh',
                    child: Text('Low to High',style: AppConst.descriptionText),
                  ),
                  DropdownMenuItem(
                    value: 'highToLow',
                    child: Text('High to Low',style: AppConst.descriptionText),
                  ),
                ],
              ))
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
                  itemCount: stores.length,
                    itemBuilder: (BuildContext context, int index){
                    StoreModel store = stores[index];
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            StoreShopNowTile(title: store.name, image: store.logo,subtitle: store.promotionCashbackStatus == 'active' && store.promotionCashbackDate.startDate.isAfter(DateTime.now()) && store.promotionCashbackDate.endDate.isBefore(DateTime.now()) ? '${store.promotionCashback} % Cashback' : null,),
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

class PewPew extends StatelessWidget {
  final List<SpecialOfferTileData> data;
  PewPew({this.data});
  @override
  Widget build(BuildContext context) {
    return data.length > 0 ? ListView.builder(
        itemCount: data.length > 6 ? 6 : data.length,
        itemBuilder: (BuildContext context, int index){
          return SpecialOfferTile(
            data: data[index]
          );
        }
    ) : Center(child: Text('Nothing Avaialble'));
  }
}
