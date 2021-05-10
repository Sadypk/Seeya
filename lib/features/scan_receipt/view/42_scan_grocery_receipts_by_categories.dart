import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:seeya/features/scan_receipt/view/40_scan_your_receipt.dart';
import 'package:seeya/main_app/models/45_model.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';
import 'package:seeya/newMainAPIs.dart';

import '55_scan_receipts.dart';

class ScanGroceryReceiptsByCategories extends StatefulWidget {
  final CatalogModel cType;

  const ScanGroceryReceiptsByCategories({Key key, this.cType}) : super(key: key);
  @override
  _ScanGroceryReceiptsByCategoriesState createState() => _ScanGroceryReceiptsByCategoriesState();
}

class _ScanGroceryReceiptsByCategoriesState extends State<ScanGroceryReceiptsByCategories> {

  bool dataLoading = true;
  List<BoomModel> favStores = [];
  List<BoomModel> nearStores = [];
  getData() async{
    favStores = await NewApi.scanReceiptsBannerFavStores(cType: widget.cType.id);
    nearStores = await NewApi.scanReceiptBannerNearMeStoreData(cType: widget.cType.id);
    setState(() {
      dataLoading = false;
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
        title: Text('Scan ${widget.cType.name} offers', style: AppConst.appbarTextStyle,),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Icon(Icons.search, size: 20,),
          SizedBox(width: 20,),
          Icon(FeatherIcons.mapPin, size: 16,),
          SizedBox(width: 20,),
        ],
      ),
      body: dataLoading ? SpinKitDualRing(color: AppConst.themePurple) : Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              SizedBox(height: 25,),
              GradientButton(
                onTap: () => Get.to(() => ScanReceipts()),
                height: 40,
                label: 'Upload receipts',
                fontStyle: AppConst.descriptionTextWhite2,
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Stores offering cashback', style: AppConst.header2,),
                  Row(
                    children: [
                      Text('Sort by', style: AppConst.descriptionText,),
                      Icon(Icons.keyboard_arrow_down_outlined, size: 18, color: Colors.black87,)
                    ],
                  )
                ],
              ),
              Divider(color: Colors.grey[200], thickness: 1, height: 20,),
              SizedBox(height: 15,),
              TabBar(
                labelColor: AppConst.black,
                labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3, color: Color(0xff9D239A)),
                unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3, color: Colors.black54),
                indicatorColor: AppConst.themePurple,
                tabs: [
                  Tab(text: 'My Favourites'),
                  Tab(text: 'Near me',)
                ],
              ),
              SizedBox(height: 10,),
              Expanded(
                child: TabBarView(
                  children: [
                    BauBau(data: favStores),
                    BauBau(data: nearStores),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
