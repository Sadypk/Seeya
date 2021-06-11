import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:seeya/features/settings/view/21_manage_address.dart';
import 'package:seeya/features/store/view/widgets/special_offer_tile.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';
import 'package:seeya/newDataViewModel.dart';
import 'package:seeya/newMainAPIs.dart';

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
    await NewApi.get45_FavStoreMainScreenData();
    setState(() {
      loading = false;
    });
  }

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Favourite shops', style: AppConst.appbarTextStyle,),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Icon(Icons.search, size: 20,),
          SizedBox(width: 20),
          GestureDetector(
              onTap: (){
                Get.to(()=> ManageAddressScreen(switchLocation: true));
              },
              child: Icon(FeatherIcons.mapPin, size: 16,)),
          SizedBox(width: 20)
        ],
      ),
      body: loading ? SpinKitDualRing(color: AppConst.themePurple) : Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.to(()=>FavouriteGroceryStores(title: 'Grocery',stores: NewDataViewModel.grocery.stores, products: NewDataViewModel.grocery.products, catalogs: NewDataViewModel.grocery.catalogs));
              },
              child: customTile('Grocery', NewDataViewModel.grocery.itemCount)
            ),
            Divider(color: Colors.grey[200], thickness: 1, height: 20,),



            InkWell(
              onTap: (){
                Get.to(()=>FavouriteGroceryStores(title: 'Fresh',stores: NewDataViewModel.fresh.stores, products: NewDataViewModel.fresh.products, catalogs: NewDataViewModel.fresh.catalogs,));

              },
              child: customTile('Fresh Items', NewDataViewModel.fresh.itemCount ?? 0)),


            Divider(color: Colors.grey[200], thickness: 1, height: 20,),

            InkWell(
              onTap: (){
                Get.to(()=>FavouriteGroceryStores(title: 'Pharmacy',stores: NewDataViewModel.pharmacy.stores, products: NewDataViewModel.pharmacy.products, catalogs: NewDataViewModel.pharmacy.catalogs,));

              },
              child: customTile('Pharmacy', NewDataViewModel.pharmacy.itemCount)),

            Divider(color: Colors.grey[200], thickness: 1, height: 20,),

            InkWell(
              onTap: (){
                Get.to(()=>FavouriteGroceryStores(title: 'Restaurant',stores: NewDataViewModel.restaurant.stores, products: NewDataViewModel.restaurant.products, catalogs: NewDataViewModel.restaurant.catalogs));

              },
              child: customTile('Restaurant', NewDataViewModel.restaurant.itemCount)),

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
                        physics: AlwaysScrollableScrollPhysics(),
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
                        child: TabBarView(
                          children: [
                            Builder(
                              builder: (_){
                                List<dynamic> data = [];
                                data.addAll(NewDataViewModel.grocery.stores.where((element) => element.promotionCashbackStatus=='active' && element.promotionCashbackDate.startDate.isBefore(DateTime.now()) && element.promotionCashbackDate.endDate.isAfter(DateTime.now())));
                                data.addAll(NewDataViewModel.fresh.stores.where((element) => element.promotionCashbackStatus=='active' && element.promotionCashbackDate.startDate.isBefore(DateTime.now()) && element.promotionCashbackDate.endDate.isAfter(DateTime.now())));
                                data.addAll(NewDataViewModel.restaurant.stores.where((element) => element.promotionCashbackStatus=='active' && element.promotionCashbackDate.startDate.isBefore(DateTime.now()) && element.promotionCashbackDate.endDate.isAfter(DateTime.now())));
                                data.addAll(NewDataViewModel.pharmacy.stores.where((element) => element.promotionCashbackStatus=='active' && element.promotionCashbackDate.startDate.isBefore(DateTime.now()) && element.promotionCashbackDate.endDate.isAfter(DateTime.now())));
                                data.addAll(NewDataViewModel.grocery.products.where((element) => element.expiryDate.isAfter(DateTime.now())));
                                data.addAll(NewDataViewModel.fresh.products.where((element) => element.expiryDate.isAfter(DateTime.now())));
                                data.addAll(NewDataViewModel.pharmacy.products.where((element) => element.expiryDate.isAfter(DateTime.now())));
                                data.addAll(NewDataViewModel.restaurant.products.where((element) => element.expiryDate.isAfter(DateTime.now())));
                                return MehMowh(data: SpecialOfferTileData.parsedList(data));
                              },
                            ),
                            Builder(builder: (_){
                              List<dynamic> data = [];
                              data.addAll(NewDataViewModel.grocery.stores.where((element) => element.promotionCashbackStatus=='active' && element.promotionCashbackDate.startDate.isBefore(DateTime.now()) && element.promotionCashbackDate.endDate.isAfter(DateTime.now())));
                              data.addAll(NewDataViewModel.grocery.products.where((element) => element.expiryDate.isAfter(DateTime.now())));

                              return MehMowh(data: SpecialOfferTileData.parsedList(data));
                            }),
                            Builder(builder: (_){
                              List<dynamic> data = [];
                              data.addAll(NewDataViewModel.fresh.stores.where((element) => element.promotionCashbackStatus=='active' && element.promotionCashbackDate.startDate.isBefore(DateTime.now()) && element.promotionCashbackDate.endDate.isAfter(DateTime.now())));
                              data.addAll(NewDataViewModel.fresh.products.where((element) => element.expiryDate.isAfter(DateTime.now())));

                              return MehMowh(data: SpecialOfferTileData.parsedList(data));
                            }),
                            Builder(builder: (_){
                              List<dynamic> data = [];
                              data.addAll(NewDataViewModel.restaurant.stores.where((element) => element.promotionCashbackStatus=='active' && element.promotionCashbackDate.startDate.isBefore(DateTime.now()) && element.promotionCashbackDate.endDate.isAfter(DateTime.now())));
                              data.addAll(NewDataViewModel.restaurant.products.where((element) => element.expiryDate.isAfter(DateTime.now())));

                              return MehMowh(data: SpecialOfferTileData.parsedList(data));
                            }),
                            Builder(builder: (_){
                              List<dynamic> data = [];
                              data.addAll(NewDataViewModel.pharmacy.stores.where((element) => element.promotionCashbackStatus=='active' && element.promotionCashbackDate.startDate.isBefore(DateTime.now()) && element.promotionCashbackDate.endDate.isAfter(DateTime.now())));
                              data.addAll(NewDataViewModel.pharmacy.products.where((element) => element.expiryDate.isAfter(DateTime.now())));

                              return MehMowh(data: SpecialOfferTileData.parsedList(data));
                            }),
                          ],
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

class MehMowh extends StatelessWidget {
  final List<SpecialOfferTileData> data;

  const MehMowh({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return data.length > 0 ? ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index){
          return SpecialOfferTile(
              data: data[index]
          );
        }
    ) : Center(child: Text('Nothing Found'));
  }
}
