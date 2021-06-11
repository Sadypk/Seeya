import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:seeya/features/home_screen/view/widgets/offer_list_tile.dart';
import 'package:seeya/main_app/models/businessTypes.dart';
import 'package:seeya/home.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/resources/string_resources.dart';
import 'package:seeya/main_app/util/screenLoader.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';
import 'package:seeya/newMainAPIs.dart';
import 'package:get/get.dart';

var offersNearYouStores = <BoomModel>[].obs;

class AllOffersNearYou extends StatefulWidget {
  @override
  _AllOffersNearYouState createState() => _AllOffersNearYouState();
}

class _AllOffersNearYouState extends State<AllOffersNearYou> {
  List<BusinessType> businessTypes;
  getData() async{
    await NewApi.getAllCategories();
    offersNearYouStores.addAll(await NewApi.get39_AllOffersNearYouData());
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    offersNearYouStores.clear();
    super.initState();
    getData();
  }

  bool loading = true;
  bool screenLoading = false;
  loadScreen() => setState(() => screenLoading = !screenLoading);
  @override
  Widget build(BuildContext context) {
    num total = 0;
    offersNearYouStores.forEach((element) {
      num offer = element.defaultWelcomeOffer;
      final today = DateTime.now();
      if(element.promotionWelcomeOfferStatus == 'active'){
        if(element.promotionWelcomeOfferDate.startDate.isBefore(today) &&  element.promotionWelcomeOfferDate.endDate.isAfter(today)){
          offer =element.promotionWelcomeOffer;
        }
      }
      total += offer;
    });
    return IsScreenLoading(
      screenLoading: screenLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('All offers near your area', style: AppConst.appbarTextStyle,),
          automaticallyImplyLeading: false,
        ),
        body: loading ? SpinKitDualRing(color: AppConst.themePurple) : Container(
          padding: const EdgeInsets.all(10),
          child: SafeArea(
            child: DefaultTabController(
              length: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('We found ${StringResources.rupee}$total+ rewards for you', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(height: 15,),
                  ButtonsTabBar(
                    backgroundColor: Colors.black54,
                    unselectedBackgroundColor: Colors.white,
                    unselectedLabelStyle: TextStyle(color: Colors.black),
                    radius: 20,
                    borderColor: Colors.grey[200],
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    borderWidth: 1,
                    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(text: 'All',),
                      Tab(text: 'Grocery',),
                      Tab(text: 'Fresh',),
                      Tab(text: 'Restaurant',),
                      Tab(text: 'Pharmacy',),
                    ],
                  ),
                  SizedBox(height: 25,),
                  Obx(()=>Expanded(
                      child: TabBarView(
                        children: [
                          PawPaw(data: offersNearYouStores),
                          PawPaw(data: offersNearYouStores.where((element) => element.businesstypeId == '5fde415692cc6c13f9e879fd').toList()),
                          PawPaw(data: offersNearYouStores.where((element) => element.businesstypeId == '5fdf434058a42e05d4bc2044').toList()),
                          PawPaw(data: offersNearYouStores.where((element) => element.businesstypeId == '5fe0bfef4657be045655cf4a').toList()),
                          PawPaw(data: offersNearYouStores.where((element) => element.businesstypeId == '5fe22e111df87913f06a4cc9').toList()),
                        ],
                      )
                  )),
                  GradientButton(
                    onTap: () async{
                      loadScreen();
                      await NewApi.get39_BtnAddAll();
                      loadScreen();
                      Get.offAll(()=>Home());
                    },
                    height: 40,
                    label: 'Claim all Rewards',
                    fontStyle: AppConst.titleText1White,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PawPaw extends StatelessWidget {
  final List data;
  const PawPaw({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index){
        return OfferListTile(data: data[index],);
      }
    );
  }
}
