import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:seeya/features/store/view/46_nearest_stores_main_page.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget.dart';
import 'package:seeya/main_app/models/45_model.dart';
import 'package:seeya/main_app/models/productModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/newMainAPIs.dart';

class NearestStoresGroceryReceipts extends StatefulWidget {
  final String typeCode;

  const NearestStoresGroceryReceipts({Key key, this.typeCode}) : super(key: key);
  @override
  _NearestStoresGroceryReceiptsState createState() => _NearestStoresGroceryReceiptsState();
}

class _NearestStoresGroceryReceiptsState extends State<NearestStoresGroceryReceipts> with SingleTickerProviderStateMixin{

  List<CatalogModel> catalogs = [];
  bool dataLoad = true;

  getData() async{
    catalogs = await NewApi.getCatalogByBusinessID(widget.typeCode);
    _tabController = TabController(length: catalogs.length, vsync: this);
    setState(() {
      dataLoad = false;
    });
  }

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest grocery stores', style: AppConst.appbarTextStyle,),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: Icon(Icons.search, size: 20,), onPressed: (){}),
          IconButton(icon: Icon(FeatherIcons.mapPin, size: 16,), onPressed: (){}),
        ],
      ),
      body: dataLoad ? Loader() : Column(
        children: [
          // Container(
          //   height: 100,
          //   margin: EdgeInsets.only(left: 20),
          //   child: ListView.builder(
          //       itemCount: catalogs.length,
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (BuildContext context, int index){
          //         final cat = catalogs[index];
          //         return Container(
          //             margin: EdgeInsets.only(right: 16, top: 25, bottom: 25),
          //             child: SquareImageWidget(image: cat.img, title: cat.name));
          //       }),
          // ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Special offers made for you', style: AppConst.titleText1,),
                    /*Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text('View All', style: AppConst.descriptionTextPurple,),
                    ),*/
                  ],
                ),
                SizedBox(height: 20,),
                ButtonsTabBar(
                  controller: _tabController,
                  backgroundColor: Color(0xff252525),
                  unselectedBackgroundColor: Colors.white,
                  unselectedLabelStyle: TextStyle(color: Color(0xff252525)),
                  radius: 20,
                  borderColor: Color(0xff707070),
                  unselectedBorderColor: Color(0xff707070),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  borderWidth: 1,
                  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: catalogs.map((e) => Tab(text: e.name)).toList()
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: catalogs.map((e) => GridListView(id: e.id)).toList()
            ),
          )
        ],
      ),
    );
  }
}

class GridListView extends StatelessWidget {
  final String id;

  const GridListView({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: NewApi.getProducts(catId: id),
      initialData: [],
      builder: (_, AsyncSnapshot<List<ProductModel>> snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return snapshot.data.length > 0 ? GridView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 12),
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