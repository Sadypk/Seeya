import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/scan_receipt/view/40_scan_your_receipt.dart';
import 'package:seeya/features/scan_receipt/view/42_scan_grocery_receipts_by_categories.dart';
import 'package:seeya/features/scan_receipt/view/43_stores_with_category_offers.dart';
import 'package:seeya/main_app/models/45_model.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';
import 'package:seeya/main_app/view/widgets/square_image_widget.dart';
import 'package:seeya/newMainAPIs.dart';

class ScanSpecificReceipt extends StatefulWidget {
  final String type;
  final String id;
  final List<BoomModel> favStores;
  final List<BoomModel> nearStores;
  ScanSpecificReceipt({this.type, this.id ,this.favStores, this.nearStores});
  @override
  _ScanSpecificReceiptState createState() => _ScanSpecificReceiptState();
}

class _ScanSpecificReceiptState extends State<ScanSpecificReceipt> {
  List<CatalogModel> catalogs = [];
  getData() async{
    catalogs = await NewApi.getCatalogByBusinessID(widget.id);
    setState(() {
      dataLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  bool dataLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan ${widget.type} receipt', style: AppConst.appbarTextStyle,),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: Icon(Icons.search, size: 20,), onPressed: (){}),
          IconButton(icon: Icon(FeatherIcons.mapPin, size: 16,), onPressed: (){}),
        ],
      ),
      body: dataLoading ? SpinKitDualRing(color: AppConst.themePurple) : DefaultTabController(
        length: 2,
        child: ListView(
          children: [
            // SizedBox(height: 25,),
            Container(
              height: 105,
              child: ListView.builder(
                  itemCount: catalogs.length,
                  padding: EdgeInsets.only(left: 20),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      onTap: (){
                        // Get.to(StoresWithCategoryOffers());
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 16, top: 25, bottom: 25),
                          child: SquareImageWidget(
                            image: catalogs[index].img,
                            title: catalogs[index].name,
                          )),
                    );
                  })
            ),
            // SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GradientButton(
                height: 40,
                label: 'Upload receipts',
                fontStyle: AppConst.descriptionTextWhite2,
              ),
            ),
            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
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
            ),
            Divider(color: Colors.grey[200], thickness: 1, height: 20,),
            SizedBox(height: 15,),
            TabBar(
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3, color: Color(0xff9D239A)),
              unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3, color: Colors.black54),
              indicatorColor: AppConst.themePurple,
              tabs: [
                Tab(text: 'My Favourites'),
                Tab(text: 'Near me',)
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 500,
              child: TabBarView(
                children: [
                  BauBau(data: widget.favStores),
                  BauBau(data: widget.nearStores)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
