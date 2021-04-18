import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';

class ScanGroceryReceiptsByCategories extends StatefulWidget {
  @override
  _ScanGroceryReceiptsByCategoriesState createState() => _ScanGroceryReceiptsByCategoriesState();
}

class _ScanGroceryReceiptsByCategoriesState extends State<ScanGroceryReceiptsByCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan vegetables offers', style: AppConst.appbarTextStyle,),
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
                  labelColor: AppConst.themePurple,
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
