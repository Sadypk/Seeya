import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/scan_receipt/view/41_scan_specific_receipts.dart';
import 'package:seeya/features/store/view/47_nearest_stores_grocery_receipts.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget.dart';
import 'package:seeya/features/store/view/widgets/special_offer_tile.dart';
import 'package:seeya/main_app/models/businessTypes.dart';
import 'package:seeya/main_app/models/productModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';
import 'package:seeya/newMainAPIs.dart';

class NearestStoresMainPage extends StatefulWidget {
  @override
  _NearestStoresMainPageState createState() => _NearestStoresMainPageState();
}

class _NearestStoresMainPageState extends State<NearestStoresMainPage> {

  Widget customTile(String label, int count){
    return Row(
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
    );
  }

  List<BusinessType> topData = [];

  bool dataLoad = true;

  ///top data
  getData() async{
    topData = await NewApi.scanReceiptCategoryCountData();

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
    var storeList = NearestStoreViewModel().storeList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest shops', style: AppConst.appbarTextStyle,),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: Icon(Icons.search, size: 20,), onPressed: (){}),
          IconButton(icon: Icon(FeatherIcons.mapPin, size: 16,), onPressed: (){}),
        ],
      ),
      body: dataLoad ? Loader() : DefaultTabController(
        length: 4,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Get.to(()=>NearestStoresGroceryReceipts(type: topData[0]));
                },
                child: customTile(topData[0].name, topData[0].count)),
              Divider(color: Colors.grey[200], thickness: 1, height: 20,),
              InkWell(
                  onTap: (){
                    Get.to(()=>NearestStoresGroceryReceipts(type: topData[1]));
                  },
                  child: customTile(topData[1].name, topData[1].count)),
              Divider(color: Colors.grey[200], thickness: 1, height: 20,),
              InkWell(
                  onTap: (){
                    Get.to(()=>NearestStoresGroceryReceipts(type: topData[2]));
                  },
                  child: customTile(topData[2].name, topData[2].count)),
              Divider(color: Colors.grey[200], thickness: 1, height: 20,),
              InkWell(
                  onTap: (){
                    Get.to(()=>NearestStoresGroceryReceipts(type: topData[3]));
                  },
                  child: customTile(topData[3].name, topData[3].count)),
              Divider(color: Colors.grey[200], thickness: 1, height: 20,),
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Special offers made for you', style: AppConst.titleText1,),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text('View All', style: AppConst.descriptionTextPurple,),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  ButtonsTabBar(
                    backgroundColor: Color(0xff252525),
                    unselectedBackgroundColor: Colors.white,
                    unselectedLabelStyle: TextStyle(color: Color(0xff252525)),
                    radius: 20,
                    borderColor: Color(0xff707070),
                    unselectedBorderColor: Color(0xff707070),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    borderWidth: 1,
                    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    tabs: topData.map((e) => Tab(text: e.name)).toList()
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Expanded(
                child: TabBarView(
                  children: topData.map((e) => GridList(id: e.id)).toList()
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: SpinKitDualRing(color: AppConst.themePurple));
  }
}


class GridList extends StatelessWidget {
  final String id;

  const GridList({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: NewApi.getProducts(bType: id),
      initialData: [],
      builder: (_, AsyncSnapshot<List<ProductModel>> snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return snapshot.data.length > 0 ? GridView.builder(
            itemCount: snapshot.data.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 162/164,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int index){
              return ProductCardWidget(data: snapshot.data[index]);
            }
          ) : Center(child: Text('Nothing Found'),);
        }else{
          return Loader();
        }
      },
    );
  }
}