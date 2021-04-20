import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/scan_receipt/view/41_scan_specific_receipts.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';

class ScanYourReceipt extends StatefulWidget {
  @override
  _ScanYourReceiptState createState() => _ScanYourReceiptState();
}

class _ScanYourReceiptState extends State<ScanYourReceipt> {

  Widget customTile(String label, int count){
    return InkWell(
      onTap: (){
        Get.to(ScanSpecificReceipt(type: label,));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleImageWidget(image: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660',),
              SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontSize: 22, fontFamily: 'Stag', ),),
                  Text('Upto 35% Cashback', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, fontFamily: 'Stag', color: Color(0xffEE1717)),)
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
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan your receipt', style: AppConst.appbarTextStyle,),
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
            SizedBox(height: 25,),
            GradientButton(
              height: 40,
              label: 'Upload receipts',
              fontStyle: AppConst.descriptionTextWhite2,
            ),
            SizedBox(height: 25,),
            Divider(color: Colors.grey[200], thickness: 1,),
            customTile('Grocery', 58),
            Divider(color: Colors.grey[200], thickness: 1, height: 20,),
            customTile('Fresh Items', 37),
            Divider(color: Colors.grey[200], thickness: 1, height: 20,),
            customTile('Pharmacy', 26),
            Divider(color: Colors.grey[200], thickness: 1, height: 20,),
            customTile('Restaurant', 32),
            Divider(color: Colors.grey[200], thickness: 1, height: 20,),
            SizedBox(height: 15,),
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
                    return Column(
                      children: [
                        StoreShopNowTile(label: 'Adidas',),
                        Divider(color: Colors.grey[200], thickness: 1, height: 20,),
                      ],
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
