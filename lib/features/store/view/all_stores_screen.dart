import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/store/view/widgets/store_tile_widget.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/store/view/store_screen.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';

class AllStoresScreen extends StatefulWidget {
  @override
  _AllStoresScreenState createState() => _AllStoresScreenState();
}

class _AllStoresScreenState extends State<AllStoresScreen> {
  @override
  Widget build(BuildContext context) {
    var storeList = NearestStoreViewModel().storeList;
    var myFavorites = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text('My Favorites', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 10,),
        Container(
          height: 150,
          child: ListView.builder(
            itemCount: storeList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index){
              return InkWell(
                onTap: (){
                  Get.to(StoreScreen(storeModel: storeList[index],));
                },
                child: Column(
                  children: [
                    CircleImageWidget(image: storeList[index].logo),
                    SizedBox(height: 5,),
                    Text(storeList[index].promotionCashback.toString(), style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),),
                    Text('Cash Back', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                    Text('was '+storeList[index].defaultCashback.toString()+'%', style: TextStyle(fontSize:12, color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
          }),
        )
      ],
    );

    var allStores = Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('All Stores', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  itemCount: storeList.length,
                  itemBuilder: (BuildContext context, int index){
                    return StoreTileWidget(storeModel: storeList[index],);
                }
                )
              )
            ],
          ),
        )
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Stores', style: TextStyle(color: Colors.black54),),
        iconTheme: IconThemeData(
            color: Colors.black54
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none, color: Colors.black54,), onPressed: null),
          IconButton(icon: Icon(Icons.favorite_border, color: Colors.black54), onPressed: null),
          IconButton(icon: Icon(Icons.shopping_bag_outlined, color: Colors.black54), onPressed: null),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 15,),
              myFavorites,
              Divider(height: 25,),
              allStores,
            ],
          ),
        ),
      ),
    );
  }
}
