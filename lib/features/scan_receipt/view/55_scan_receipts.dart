import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/scan_receipt/theBoss/view/cameraView.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/features/store/view/widgets/top_picks_card_widget.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/custom_outline_button.dart';
import 'package:seeya/newMainAPIs.dart';

class ScanReceipts extends StatefulWidget {
  @override
  _ScanReceiptsState createState() => _ScanReceiptsState();
}

class _ScanReceiptsState extends State<ScanReceipts> with SingleTickerProviderStateMixin{

  List<BoomModel> nearStores = [];
  List<BoomModel> favStores = [];
  List<BoomModel> allStores = [];

  List<BoomModel> favGroceries = [];
  List<BoomModel> favFresh = [];
  List<BoomModel> favPharmacy = [];
  List<BoomModel> favRestaurant = [];

  List<BoomModel> nearGroceries = [];
  List<BoomModel> nearFresh = [];
  List<BoomModel> nearPharmacy = [];
  List<BoomModel> nearRestaurant = [];

  bool dataLoad = true;

  TabController _tabController;
  bool fabView = true;
  getData() async{

    favStores = await NewApi.scanReceiptsFavStores();
    nearStores = await NewApi.scanReceiptNearMeStoreData();
    allStores = await NewApi.getScanReceiptPageSpecialOffersStoresData();


    favGroceries.addAll(allStores.where((element) => element.businesstypeId == '5fde415692cc6c13f9e879fd'));
    favFresh.addAll(allStores.where((element) => element.businesstypeId == '5fdf434058a42e05d4bc2044'));
    favRestaurant.addAll(allStores.where((element) => element.businesstypeId == '5fe0bfef4657be045655cf4a'));
    favPharmacy.addAll(allStores.where((element) => element.businesstypeId == '5fe22e111df87913f06a4cc9'));

    nearGroceries.addAll(allStores.where((element) => element.businesstypeId == '5fde415692cc6c13f9e879fd'));
    nearFresh.addAll(allStores.where((element) => element.businesstypeId == '5fdf434058a42e05d4bc2044'));
    nearPharmacy.addAll(allStores.where((element) => element.businesstypeId == '5fe0bfef4657be045655cf4a'));
    nearRestaurant.addAll(allStores.where((element) => element.businesstypeId == '5fe22e111df87913f06a4cc9'));

    _tabController = TabController(length: 2, vsync: this)..addListener(() {
      if(_tabController.index == 0){
        setState(() {
          fabView = true;
        });
      }else{
        setState(() {
          fabView = false;
        });
      }
    });

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
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Scan Receipts', style: AppConst.appbarTextStyle,),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Icon(CupertinoIcons.search, color: Colors.white),
          SizedBox(width: 20,)
        ],
      ),
      body: dataLoad ? SpinKitDualRing(color: AppConst.themePurple) : ListView(
        children: [
          TabBar(
            controller: _tabController,
              labelColor: Colors.black,
              indicatorColor: AppConst.themePurple,
              labelStyle: AppConst.header2,
              unselectedLabelStyle: AppConst.header2,
              tabs: [
                Tab(text: 'My favourite',),
                Tab(text: 'Near me',),
              ]),
          SizedBox(height: 15,),
          SizedBox(
            height: Get.height * .8,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text('Recently visited stores', style: AppConst.header2,),
                        ],
                      ),
                    ),
                    Divider(height: 20,),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: Get.height * .31,
                      child: LauLau(data: favStores)
                    ),
                    SizedBox(height: 20,),
                    favStores.length > 6 ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomOutlineButton(
                          onTap: (){
                          },
                          label: 'View all offers',
                          height: 28,
                          width: 160,
                          fontStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'Stag'),
                        )
                      ],
                    ) : SizedBox(),
                    SizedBox(height: 25,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
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
                    ),
                    SizedBox(height: 20,),
                    DefaultTabController(
                      length: 5,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
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
                            SizedBox(height: 15,),
                            Container(
                              height: 500,
                              child: TabBarView(
                                children: [
                                  KhauKhau(data: allStores),
                                  KhauKhau(data: favGroceries),
                                  KhauKhau(data: favFresh),
                                  KhauKhau(data: favRestaurant),
                                  KhauKhau(data: favPharmacy),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                DefaultTabController(
                  length: 5,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
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
                        SizedBox(height: 15,),
                        Expanded(
                          child: TabBarView(
                            children: [
                              KhauKhau(data: nearStores),
                              KhauKhau(data: nearGroceries),
                              KhauKhau(data: nearFresh),
                              KhauKhau(data: nearRestaurant),
                              KhauKhau(data: nearPharmacy),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class KhauKhau extends StatelessWidget {
  final List<BoomModel> data;

  const KhauKhau({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: (){
              Get.to(() => TheBossCameraScreen(storeModel: data[index]));
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    StoreShopNowTile2(label: 'Something', boomModel: data[index]),
                    Divider(height: 40,)
                  ],
                )),
          );
        });
  }
}


class LauLau extends StatelessWidget {
  final List<BoomModel> data;

  const LauLau({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          childAspectRatio: .9
        ),
        itemCount: data.length > 6 ? 6 : data.length,
        itemBuilder: (_, index) => GestureDetector(
          onTap: (){
            Get.to(() => TheBossCameraScreen(storeModel: data[index]));
          },
          child: Column(
            children: [
              TopPicksCardWidget(storeModel: StoreModel(promotionCashback: 25, logo: data[index].logo), height: 90, width: 100, fontSize: 8,),
              SizedBox(height: 10,),
              Text(data[index].name, style: AppConst.header2 ,)
            ],
          ),
        )
    );
  }
}
