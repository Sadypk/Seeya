import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/home_screen/view_models/top_products_view_model.dart';
import 'package:seeya/features/store/view/all_stores_screen.dart';
import 'package:seeya/features/home_screen/models/banner_model.dart';
import 'package:seeya/features/home_screen/view/widgets/banner_card_widget.dart';
import 'package:seeya/features/store/view/widgets/store_tile_widget.dart';
import 'package:seeya/features/home_screen/view/widgets/products_tile_widget.dart';
import 'package:seeya/main_app/models/product_model.dart';
import 'package:seeya/features/store/models/store_model.dart';
import 'package:seeya/main_app/view/widgets/custom_text_from_field.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final controller = PageController(initialPage: 0, viewportFraction: 0.9);
  @override
  Widget build(BuildContext context) {
    List<BannerModel> bannerList = [
      BannerModel(
        title: 'Start shopping and get a \$10 Bonus',
        bannerDescription: 'Select a store, then tap \"Shop\"\n\n' 'Swipe to learn more >',
        bannerBackgroundImage: ''
      ),
      BannerModel(
          title: 'Start shopping and get a \$10 Bonus',
          bannerDescription:
          "Select a store, then tap"
          "Swipe to learn more >",
          bannerBackgroundImage: ''
      ),
    ];
    var bannerWidget = Container(
      padding: EdgeInsets.only(bottom: 5),
      height: 155,
      // width: 200,
      child: PageView.builder(
        controller: controller,
        itemCount: bannerList.length,
        itemBuilder: (BuildContext context, int index){
          return BannerCardWidget(bannerList[index]);
        },
      ),
    );

    var storeList1 = NearestStoreViewModel().storeList;
    var nearestStore = Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Online & in stores', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              InkWell(
                onTap: (){Get.to(AllStoresScreen());},
                child: Text('See All', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),)
              ),
            ],
          ),
          Text('Last-minute gifts with Double Cash Back', style: TextStyle(fontSize: 12, color: Colors.grey),),
          SizedBox(height: 15,),
          StoreTileWidget(storeModel: storeList1[0], isClaimable: true,),
          StoreTileWidget(storeModel: storeList1[1], isClaimable: true),
          StoreTileWidget(storeModel: storeList1[2], isClaimable: true),
        ],
      ),
    );


    var productList1 = TopProductsViewModel().productList;
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
                  onTap: (){Get.to(AllStoresScreen());},
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
              return ProductsTileWidget(productModel: productList1[index], );
            },
          ),
        ),
      ],
    );


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(icon: Icon(FeatherIcons.user), onPressed: null),
          IconButton(icon: Icon(FeatherIcons.messageCircle), onPressed: null),
          IconButton(icon: Icon(Icons.shopping_bag_outlined), onPressed: null),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Column(
            children: [
              // Row(
              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   mainAxisSize: MainAxisSize.max,
              //   children: [
              //     Expanded(
              //       child: searchBox,
              //     ),
              //     IconButton(icon: Icon(Icons.message, color: Colors.grey,), onPressed: (){})
              //   ],
              // ),
              SizedBox(height: 10,),
              Expanded(child: ListView(
                children: [
                  bannerWidget,
                  Divider(height: 30,),
                  nearestStore,
                  SizedBox(height: 10,),
                  topProducts,
                  SizedBox(height: 25 ,),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
