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
import 'package:seeya/features/redeem_balance/repo/redeem_balance_repo.dart';
import 'package:seeya/features/redeem_balance/view/redeem_instore.dart';
import 'package:seeya/features/redeem_balance/view/redeem_online.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/newMainAPIs.dart';

class MyRedeemBalance extends StatefulWidget {
  @override
  _MyRedeemBalanceState createState() => _MyRedeemBalanceState();
}

class _MyRedeemBalanceState extends State<MyRedeemBalance>
    with SingleTickerProviderStateMixin {
  bool dataLoad = true;

  List<StoreData> allStores = [];
  List<StoreData> redeemOnline = [];
  List<StoreData> redeemInStore = [];
  bool matcher = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    allStores = await MyRedeemBalanceRepo.getMyRedeem();
    redeemOnline.addAll(allStores.where((element) => element.online == true));
    redeemInStore.addAll(allStores.where((element) => element.online == false));

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
          'Redeem Balance',
          style: AppConst.appbarTextStyle,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: dataLoad
          ? SpinKitDualRing(color: AppConst.themePurple)
          : DefaultTabController(
        length: 2,
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
                    text: 'InStore',
                  ),
                  Tab(
                    text: 'Online',
                  ),
                ]),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  RedeemInStore(
                    redeemInStores: redeemInStore,
                  ),
                  RedeemOnline(
                    redeemOnlineStores: redeemOnline,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
