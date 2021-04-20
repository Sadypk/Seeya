import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/scan_receipt/view/42_scan_grocery_receipts_by_categories.dart';
import 'package:seeya/features/scan_receipt/view/43_stores_with_category_offers.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';
import 'package:seeya/main_app/view/widgets/square_image_widget.dart';

class ScanSpecificReceipt extends StatefulWidget {
  final String type;
  ScanSpecificReceipt({this.type});
  @override
  _ScanSpecificReceiptState createState() => _ScanSpecificReceiptState();
}

class _ScanSpecificReceiptState extends State<ScanSpecificReceipt> {
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            // SizedBox(height: 25,),
            Container(
              height: 100,
              child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      onTap: (){
                        Get.to(StoresWithCategoryOffers());
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 16, top: 25, bottom: 25),
                          child: SquareImageWidget(image: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660',)),
                    );
                  }),
            ),
            // SizedBox(height: 25,),
            GradientButton(
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
            DefaultTabController(
                length: 2,
                child: TabBar(
                  labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3, color: Color(0xff9D239A)),
                  unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3, color: Colors.black54),
                  indicatorColor: AppConst.themePurple,
                  tabs: [
                    Tab(text: 'My Favourites'),
                    Tab(text: 'Near me',)
                  ],
                )
            ),
            SizedBox(height: 10,),
            Container(
              height: 500,
              child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      onTap: (){
                        Get.to(ScanGroceryReceiptsByCategories());
                      },
                      child: Column(
                        children: [
                          StoreShopNowTile(label: 'Adidas',),
                          Divider(color: Colors.grey[200], thickness: 1, height: 20,),
                        ],
                      ),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
