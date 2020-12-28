import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seeya/features/home_screen/view/widgets/nearest_store_tile_widget.dart';
import 'package:seeya/features/home_screen/view/widgets/top_products_tile_widget.dart';
import 'package:seeya/features/search_nearest_products_stores/view/search_nearest_products_stores.dart';
import 'package:seeya/main_app/models/product_model.dart';
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

    List<ProductModel> productList1 = [
      ProductModel(
        productId: 21,
        productImage: 'https://mcdonalds.com.au/sites/mcdonalds.com.au/files/Product-Details-BigMac-mobile-201904.jpg',
        productName: 'Big Mac',
        productPrice: 29.99,
      ),
      ProductModel(
        productId: 22,
        productImage: 'https://www.mcdonalds.com/content/dam/usa/nfl/nutrition/items/regular/desktop/t-mcdonalds-Fries-Small-Medium.jpg',
        productName: 'McDonalds Fries',
        productPrice: 9.99,
      ),
      ProductModel(
        productId: 31,
        productImage: 'https://recipefairy.com/wp-content/uploads/2020/07/kfc-chicken-500x375.jpg',
        productName: 'Chicken Fry',
        productPrice: 14.99,
      ),
      ProductModel(
        productId: 32,
        productImage: 'https://assets.newatlas.com/dims4/default/7c0af90/2147483647/strip/true/crop/1372x915+0+0/resize/1372x915!/quality/90/?url=http%3A%2F%2Fnewatlas-brightspot.s3.amazonaws.com%2Fb8%2F01%2F42fb621748ceb2a3c56f158d373f%2Fbucket-tenders-laying.jpeg',
        productName: 'Chicken Nuggets',
        productPrice: 12,
      ),
    ];
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
          height: 210,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            itemCount: productList1.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return TopProductsTileWidget(productModel: productList1[index],);
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
