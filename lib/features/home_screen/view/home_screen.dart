import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seeya/features/chat/view/chatScreen.dart';
import 'package:seeya/features/order_online/view/cart_page.dart';
import 'package:seeya/features/scan_receipt/view/40_scan_your_receipt.dart';
import 'package:seeya/features/scan_receipt/view/45_fav_stores_main_page.dart';
import 'package:seeya/features/settings/view/21_manage_address.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/features/store/view/46_nearest_stores_main_page.dart';
import 'package:seeya/features/store/view/widgets/offer_cards_gradient.dart';
import 'package:seeya/features/store/view/widgets/special_offer_tile.dart';
import 'package:seeya/main_app/models/addressModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';
import 'package:seeya/newDataViewModel.dart';
import 'package:seeya/newMainAPIs.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController(initialPage: 0, viewportFraction: 0.9);
  List<StoreModel> list = [];
  double padding = 20;

  @override
  void initState() {
    getNearestStore();
    getAddresses();
    super.initState();
  }

  bool loading = true;

  getNearestStore() async {
    await NewApi.getAllCategories();
    await NewApi.getHomeFavShops();
    NewDataViewModel.homeSpecialDataRecent
        .addAll(await NewApi.getHomePageSpecialOfferAndCategoryData(''));
    NewDataViewModel.homeSpecialDataGrocery.addAll(
        await NewApi.getHomePageSpecialOfferAndCategoryData(
            '5fde415692cc6c13f9e879fd'));
    NewDataViewModel.homeSpecialDataFresh.addAll(
        await NewApi.getHomePageSpecialOfferAndCategoryData(
            '5fdf434058a42e05d4bc2044'));
    NewDataViewModel.homeSpecialDataRestaurant.addAll(
        await NewApi.getHomePageSpecialOfferAndCategoryData(
            '5fe0bfef4657be045655cf4a'));
    NewDataViewModel.homeSpecialDataPharmacy.addAll(
        await NewApi.getHomePageSpecialOfferAndCategoryData(
            '5fe22e111df87913f06a4cc9'));
    setState(() {
      loading = false;
    });
  }

  List<PopupMenuItem<AddressModel>> popup = [];

  getAddresses() {
    UserViewModel.user.value.addresses.forEach((element) {
      popup.add(
        PopupMenuItem<AddressModel>(
            child: GestureDetector(onTap: () {
              Get.back();
              print(element.id);
            }, child: Text(element.address)),
            value: element),
      );
    });
  }

  AddressModel selectedAddress = UserViewModel.user.value.addresses[UserViewModel.locationIndex.value];

  @override
  Widget build(BuildContext context) {
    var bannerWidget = InkWell(
      child: AspectRatio(
        aspectRatio: 375 / 112,
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: padding),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: .5)),
              image: DecorationImage(
                  image: AssetImage('assets/images/banner.png'),
                  fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(0, -1),
                    spreadRadius: 3,
                    blurRadius: 3)
              ]),
        ),
      ),
      onTap: () {
        Get.to(ScanYourReceipt());
      },
    );

    var favoriteShops = Container(
      padding: EdgeInsets.only(left: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border_rounded),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'You favorite stores',
                    style: AppConst.header2,
                  ),
                ],
              ),
              InkWell(
                  onTap: () async {
                    // await NewApi.get45_FavStoreMainScreenData();
                    //
                    Get.to(FavStoresMainPage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      'View All',
                      style: AppConst.descriptionTextPurple,
                    ),
                  )),
            ],
          ),
          SizedBox(height: 6),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: NewDataViewModel.homeFavStores.length > 3
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              children: NewDataViewModel.homeFavStores
                  .map((e) => Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleImageWidget(image: e.logo),
                            SizedBox(height: 12),
                            Text(
                                '${e.name.length > 10 ? e.name.substring(0, 9) + '...' : e.name}',
                                style: AppConst.descriptionText2),
                            Text('${e.defaultCashback}% cashback',
                                style: AppConst.descriptionTextPurple),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );

    var gradientCards = Container(
      height: 90,
      padding: EdgeInsets.only(left: 20),
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: NewDataViewModel.businessTypes.length,
          itemBuilder: (_, index) => OfferCardsGradient(
                title: NewDataViewModel.businessTypes[index].name,
                description: 'Get all offer now',
                begin: gradients[index]['begin'],
                end: gradients[index]['end'],
                data: NewDataViewModel.businessTypes[index],
              )),
    );

    meowList(List<dynamic> datas) => datas.length > 0
        ? ListView.builder(
            itemCount: datas.length,
            primary: false,
            padding: EdgeInsets.only(bottom: 50),
            itemBuilder: (BuildContext context, int index) {
              SpecialOfferTileData data =
                  SpecialOfferTileData.convertData(datas[index]);
              return SpecialOfferTile(data: data);
            })
        : Align(
            alignment: Alignment.topCenter, child: Text('Nothing available'));

    var specialOffers = DefaultTabController(
        length: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Special offers made for you',
                    style: AppConst.titleText1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                        onTap: () {
                          Get.to(NearestStoresMainPage());
                        },
                        child: Text(
                          'View All',
                          style: AppConst.descriptionTextPurple,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
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
              SizedBox(
                height: 10,
              ),
              Container(
                height: 500,
                child: TabBarView(
                  children: [
                    meowList(NewDataViewModel.homeSpecialDataRecent),
                    meowList(NewDataViewModel.homeSpecialDataGrocery),
                    meowList(NewDataViewModel.homeSpecialDataFresh),
                    meowList(NewDataViewModel.homeSpecialDataRestaurant),
                    meowList(NewDataViewModel.homeSpecialDataPharmacy),
                  ],
                ),
              )
            ],
          ),
        ));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: DropdownButtonHideUnderline(
          child: DropdownButton<AddressModel>(
            value:  selectedAddress,
            onChanged: (address){
              print(address.address);
              setState(() {
                selectedAddress = address;
              });
              UserViewModel.setLocationIndex(UserViewModel.user.value.addresses.indexOf(address));
              UserViewModel.setLocation(LatLng(address.location.lat, address.location.lng), address.id);
            },
            items: UserViewModel.user.value.addresses.map((addr) => DropdownMenuItem(
              child: Container(
                width: Get.width*.3,
                child: Text(
                  addr.address,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(0xff252525), fontSize: 14),
                ),
              ),
              value: addr,
            )).toList(),
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              icon: Icon(
                FeatherIcons.bell,
                size: 18,
              ),
              onPressed: () async {
                await NewApi.getHomePageSpecialOfferAndCategoryData('');
              }),
          IconButton(
              icon: Icon(
                FeatherIcons.messageSquare,
                size: 18,
              ),
              onPressed: () async {
                if (UserViewModel.userStatus.value == UserStatus.LOGGED_IN) {
                  Get.to(() => ChatScreen());
                } else {
                  /// do what you want when user is not logged in
                  Get.snackbar('Nope', 'not logged in');
                }
              }),
          IconButton(
              icon: Icon(FeatherIcons.shoppingCart, size: 18),
              onPressed: () {
                Get.to(() => CartPage());
              }),
          SizedBox(width: 8)
        ],
      ),
      body: loading
          ? SpinKitDualRing(color: AppConst.themePurple)
          : SafeArea(
              child: ListView(
                children: [
                  bannerWidget,
                  SizedBox(
                    height: 20,
                  ),
                  favoriteShops,
                  SizedBox(
                    height: 25,
                  ),
                  gradientCards,
                  SizedBox(
                    height: 25,
                  ),
                  specialOffers,
                ],
              ),
            ),
    );
  }
}

final gradients = [
  {
    'begin': Color(0xff664FB0),
    'end': Color(0xffDA58D7),
  },
  {
    'begin': Color(0xff8D67E5),
    'end': Color(0xffD590C1),
  },
  {
    'begin': Color(0xffEF6DA0),
    'end': Color(0xffEE8E6B),
  },
  {
    'begin': Color(0xff83EAF1),
    'end': Color(0xff63A4FF),
  },
];
