import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:seeya/features/chat/view/chatScreen.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/home_screen/view_models/top_products_view_model.dart';
import 'package:seeya/features/products/view/top_products_screen.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/features/store/view/all_stores_screen.dart';
import 'package:seeya/features/home_screen/models/banner_model.dart';
import 'package:seeya/features/home_screen/view/widgets/banner_card_widget.dart';
import 'package:seeya/features/store/view/store_screen.dart';
import 'package:seeya/features/store/view/widgets/circle_image_widget.dart';
import 'package:seeya/features/store/view/widgets/store_tile_widget.dart';
import 'package:seeya/features/home_screen/view/widgets/products_tile_widget.dart';
import 'package:seeya/mainRepoWithAllApi.dart';
import 'package:get/get.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController(initialPage: 0, viewportFraction: 0.9);
  List<StoreModel> list = [];

  @override
  void initState() {
    getNearestStore();
    super.initState();
  }

  getNearestStore()async{
    list.addAll(await MainRepo.getAllNearestStore());
  }

  @override
  Widget build(BuildContext context) {
    List<BannerModel> bannerList = [
      BannerModel(
        title: 'Start shopping and get a \$10 Bonus',
        bannerDescription: 'Select a store, then tap \"Shop\"\n\n' 'Swipe to learn more >',
        bannerBackgroundImage: 'https://image.freepik.com/free-vector/fashion-promotion-store-banner-gradient-modern-background-template_8306-296.jpg'
      ),
      BannerModel(
          title: 'Start shopping and get a \$10 Bonus',
          bannerDescription:
          "Select a store, then tap"
          "Swipe to learn more >",
          bannerBackgroundImage: 'https://thumbs.dreamstime.com/z/bright-banner-page-online-shopping-store-template-modern-flat-webpage-design-concept-website-mobile-happy-girl-vector-136259459.jpg'
      ),
    ];
    var bannerWidget = Container(
      padding: EdgeInsets.only(bottom: 5),
      height: 155,
      // width: 200,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: bannerList.length,
        itemBuilder: (BuildContext context, int index){
          return BannerCardWidget(bannerList[index]);
        },
      ),
    );


    var storeList = NearestStoreViewModel().storeList;
    var favoriteShops = Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border_rounded),
                  SizedBox(width: 5,),
                  Text('Online & in stores', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                ],
              ),
              InkWell(
                  onTap: (){Get.to(AllStoresScreen());},
                  child: Text('View All', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),)
              ),
            ],
          ),
          SizedBox(height: 15,),
          Container(
            height: 110,
            child: ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index){
              return Container(
                margin: EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: (){
                    Get.to(StoreScreen(storeModel: storeList[0],));
                  },
                  child: Column(
                    children: [
                      CircleImageWidget(image: storeList[0].logo),
                      SizedBox(height: 5,),
                      Text(storeList[0].name, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                      Text('${storeList[0].defaultCashback}% cashback', style: TextStyle(fontSize:12, color: Colors.green, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );

    var nearestStore = FutureBuilder(
      future: MainRepo.getAllNearestStore(),
      builder: (_, AsyncSnapshot<List<StoreModel>>snapshot){
        if(snapshot.hasData && snapshot.data != null){
          if(snapshot.data == null){
            return Text('something went wrong');
          }else if(snapshot.data.length == 0){

            return Container(
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
                  Text('No stores found', style: TextStyle(fontSize: 12, color: Colors.grey),),
                  SizedBox(height: 15,),
                ],
              ),
            );
          }else{
            return Container(
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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return StoreTileWidget(storeModel: snapshot.data[i], isClaimable: true, onTap: (){Get.to(StoreScreen(storeModel: snapshot.data[i],));},);
                    },
                  ),
                ],
              ),
            );
          }
        }else{
          return SpinKitWave(color: Theme.of(context).primaryColor);
        }
      },
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
              onPressed: (){},
              child: InkWell(
                  onTap: (){Get.to(TopProductsScreen());},
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
          IconButton(icon: Icon(FeatherIcons.user, color: Colors.grey,), onPressed: (){}),
          IconButton(icon: Icon(FeatherIcons.messageCircle, color: Colors.grey), onPressed: () async{
            if(UserViewModel.userStatus.value == UserStatus.LOGGED_IN){
              Get.to(()=>ChatScreen());
            }else{
              /// do what you want when user is not logged in
              Get.snackbar('Nope', 'not logged in');
            }
          }),
          IconButton(icon: Icon(Icons.shopping_bag_outlined, color: Colors.grey), onPressed: (){}),
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
                  favoriteShops,
                  SizedBox(height: 10,),
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
