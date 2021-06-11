import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:seeya/features/order_online/repo/my_fav_repo.dart';
import 'package:seeya/features/order_online/repo/my_special_offers.dart';
import 'package:seeya/features/order_online/repo/near_me_repo.dart';
import 'package:seeya/features/order_online/view/my_fav.dart';
import 'package:seeya/features/order_online/view/near_me.dart';
import 'package:seeya/features/order_online/view/search_store.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/newMainAPIs.dart';

class OrderOnline extends StatefulWidget {
  @override
  _OrderOnlineState createState() => _OrderOnlineState();
}

class _OrderOnlineState extends State<OrderOnline>
    with SingleTickerProviderStateMixin {
  bool dataLoad = true;
  List<BoomModel> specialOffers;
  List<BoomModel> favStores;
  List<BoomModel> allNearStores;
  List<BoomModel> allStores = [];
  bool matcher = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    favStores = await MyFavRepo.getMyFav();
    specialOffers = await MySpecialOffers.getMySpecialOffers();
    allNearStores = await NearMeRepo.getNearMe();

    allStores.addAll(favStores);
    specialOffers.forEach((specialElement) {
      allStores.forEach((allElement) {
        matcher = false;
        if (specialElement.id == allElement.id) {
          matcher = true;
        }
      });
      if (!matcher) {
        allStores.add(specialElement);
      }
    });

    allNearStores.forEach((nearElement) {
      allStores.forEach((allElement) {
        matcher = false;
        if (nearElement.id == allElement.id) {
          matcher = true;
        }
      });
      if (!matcher) {
        allStores.add(nearElement);
      }
    });

    setState(() {
      dataLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Text(
                'Order Online',
                style: AppConst.appbarTextStyle,
              ),
              iconTheme: IconThemeData(color: Colors.white),
              actions: [
                IconButton(
                  onPressed: () => Get.to(() => SearchStore(allStores: allStores,)),
                  icon: Icon(CupertinoIcons.search, color: Colors.white),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            body: dataLoad
                ? SpinKitDualRing(color: AppConst.themePurple)
                : DefaultTabController(
              length: 2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                        labelColor: Colors.black,
                        indicatorColor: AppConst.themePurple,
                        labelStyle: AppConst.header2,
                        unselectedLabelStyle: AppConst.header2,
                        tabs: [
                          Tab(
                            text: 'My favourite',
                          ),
                          Tab(
                            text: 'Near me',
                          ),
                        ]),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          MyFav(
                            favStores: favStores,
                            specialOffers: specialOffers,
                          ),
                          NearMe(
                            allNearStores: allNearStores,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
