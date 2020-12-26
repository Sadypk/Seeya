import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seeya/features/home_screen/view/widgets/nearest_store_tile_widget.dart';
import 'package:seeya/features/home_screen/view/widgets/top_products_tile_widget.dart';
import 'package:seeya/features/search_nearest_products_stores/view/search_nearest_products_stores.dart';
import 'package:seeya/main_app/view/widgets/custom_text_from_field.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var bannerWidget = Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.orange[200],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Text('Banner'),
      ),
    );

    var nearestStore = Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nearest Stores', style: TextStyle(fontWeight: FontWeight.bold),),
              InkWell(
                onTap: (){Get.to(SearchNearestProductsStores());},
                child: Text('View All', style: TextStyle(color: Colors.blue),)
              ),
            ],
          ),
          SizedBox(height: 15,),
          NearestStoreTileWidget(),
          SizedBox(height: 7,),
          NearestStoreTileWidget(),
          SizedBox(height: 7,),
          NearestStoreTileWidget(),
        ],
      ),
    );

    var topProducts = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text('Top Products',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            RawMaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              // onPressed: widget.onTapViewAll,
              child: InkWell(
                  onTap: (){Get.to(SearchNearestProductsStores());},
                  child: Text('View All', style: TextStyle(color: Colors.blue),)
              ),
            )
          ],),

        Container(
          height: 202,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return TopProductsTileWidget();
            },
          ),
        ),
      ],
    );

    var searchBox = Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey[300], width: 1),
        boxShadow: [
          BoxShadow(
              color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
          BoxShadow(
              color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 5,),
          Icon(Icons.search, size: 20, color: Colors.grey,),
          SizedBox(width: 5,),
          Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    hintText: 'Search'
                ),
              )
          )
        ],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: searchBox,
                  ),
                  IconButton(icon: Icon(Icons.message, color: Colors.grey,), onPressed: (){})
                ],
              ),
              SizedBox(height: 10,),
              Expanded(child: ListView(
                children: [
                  bannerWidget,
                  SizedBox(height: 10,),
                  nearestStore,
                  SizedBox(height: 10,),
                  topProducts
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
