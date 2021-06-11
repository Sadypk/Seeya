import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/settings/view/21_manage_address.dart';
import 'package:seeya/features/store/view/widgets/special_offer_tile.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/resources/string_resources.dart';
import 'package:seeya/main_app/view/widgets/custom_outline_button.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';
import 'package:seeya/main_app/view/widgets/square_image_widget.dart';
import '40_scan_your_receipt.dart';
import '43_stores_with_category_offers.dart';
import '45_fav_stores_main_page.dart';
import 'package:seeya/main_app/models/45_model.dart';

class FavouriteGroceryStores extends StatefulWidget {
  final String title;
  final List<StoreModel> stores;
  final List<ProductDamnModel> products;
  final List<CatalogModel> catalogs;

  const FavouriteGroceryStores({Key key,@required this.title,@required this.stores,@required this.products, @required this.catalogs}) : super(key: key);
  @override
  _FavouriteGroceryStoresState createState() => _FavouriteGroceryStoresState();
}

class _FavouriteGroceryStoresState extends State<FavouriteGroceryStores> {
  List<Tab> tabs = [];
  List<Widget> tabViews = [];
  List<StoreModel> stores = [];
  @override
  void initState() {
    super.initState();
    stores = widget.stores;
    tabs.add(Tab(
      text: "Recent",
    ));

    tabs.addAll(widget.catalogs.map((e) => Tab(text: e.name)).toList());
    tabViews.add(PewPew(data: SpecialOfferTileData.parsedList(widget.products)));
    widget.catalogs.forEach((element) {
      tabViews.add(PewPew(data: SpecialOfferTileData.parsedList(widget.products.where((pro) => pro.catId == element.id))));
    });
  }

  String filterValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        titleSpacing: 0,
        title: Text('Favourite ${widget.title} stores', style: AppConst.appbarTextStyle,),
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
      body: Column(
        children: [
          Container(
            height: 105,
            margin: EdgeInsets.only(left: 20),
            child: ListView.builder(
                itemCount: widget.catalogs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    onTap: (){
                      Get.to(()=>StoresWithCategoryOffers(title: widget.catalogs[index].name,stores: widget.stores));
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 16, top: 25, bottom: 25),
                        child: SquareImageWidget(
                          title: widget.catalogs[index].name,
                          image: widget.catalogs[index].img,)),
                  );
                }),
          ),
          DefaultTabController(
              length: widget.catalogs.length + 1,
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
                      tabs: tabs,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 200,
                      child: TabBarView(
                        children: tabViews,
                      ),
                    )
                  ],
                ),
              )
          ),
          SizedBox(height: 15,),
          if(widget.products.length > 6)Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomOutlineButton(
                onTap: (){
                  Get.to(FavStoresMainPage());
                },
                label: 'View all offers',
                height: 28,
                width: 160,
                fontStyle: TextStyle(fontSize: 12,fontFamily: 'Stag'),
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
                DropDownIcon(
                  onPress: (){
                    Get.bottomSheet(Stack(
                      children: [
                        Container(
                          height: Get.height * .35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)
                              )
                          ),
                          child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) _setState) {

                            onChanged(value){
                              _setState((){
                                filterValue = value;
                              });
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                                  child: Text(
                                      'Sort by',
                                      style: AppConst.titleText2
                                  ),
                                ),
                                SizedBox(height: 12),

                                SizedBox(
                                  height: 40,
                                  child: RadioListTile(
                                    value: 'distance',
                                    groupValue: filterValue,
                                    onChanged: onChanged,
                                    contentPadding: EdgeInsets.only(left: 8),
                                    activeColor: AppConst.themePurple,
                                    title: Text(
                                        'Distance'
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: RadioListTile(
                                    value: 'cashback',
                                    groupValue: filterValue,
                                    onChanged: onChanged,
                                    contentPadding: EdgeInsets.only(left: 8),
                                    activeColor: AppConst.themePurple,
                                    title: Text(
                                        'Cashback'
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: RadioListTile(
                                    value: 'az',
                                    groupValue: filterValue,
                                    onChanged: onChanged,
                                    contentPadding: EdgeInsets.only(left: 8),
                                    activeColor: AppConst.themePurple,
                                    title: Text(
                                        'A-Z'
                                    ),
                                  ),
                                ),

                                Spacer(),
                                Center(
                                  child: GradientButton(
                                    height: 45,
                                    width: Get.width * .9,
                                    onTap: (){

                                      setState(() {
                                        if(filterValue == 'distance'){
                                          stores.sort((a,b) => a.calculated_distance.compareTo(b.calculated_distance));
                                        }else if(filterValue == 'cashback'){
                                          stores.sort((a,b) => a.defaultCashback.compareTo(b.defaultCashback));
                                        }else if(filterValue == 'az'){
                                          stores.sort((a,b) => a.name.compareTo(b.name));
                                        }
                                      });

                                      Get.back();

                                    },
                                    label: 'Done',
                                    fontStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                              ],
                            );
                          },),
                        ),

                        Positioned(
                          right: 0,
                          child: CloseButton(),
                        )
                      ],
                    ));
                  },
                ),
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
                            StoreShopNowTile(
                              title: store.name,
                              image: store.logo,
                              subtitle: store.promotionCashbackStatus == 'active' && store.promotionCashbackDate.startDate.isAfter(DateTime.now()) && store.promotionCashbackDate.endDate.isBefore(DateTime.now()) ? '${store.promotionCashback} % Cashback' : null,
                            ),
                            Divider(height: 20)
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

  const PewPew({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return data.length > 0 ? ListView.builder(
        itemCount: data.length > 2 ? 2 : data.length,
        itemBuilder: (BuildContext context, int index){
          return SpecialOfferTile(data: data[index]);
        }
    ) : Center(
      child: Text(
        'Nothing available'
      ),
    );
  }
}

