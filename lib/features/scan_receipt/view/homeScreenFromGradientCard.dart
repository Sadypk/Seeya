import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/settings/view/21_manage_address.dart';
import 'package:seeya/main_app/config/gqlConfig.dart';
import 'package:seeya/main_app/models/45_model.dart';
import 'package:seeya/main_app/models/businessTypes.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';
import 'package:seeya/main_app/view/widgets/custom_outline_button.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';

import '40_scan_your_receipt.dart';

class HomeScreenFromGradientCard extends StatefulWidget {
  final BusinessType data;

  const HomeScreenFromGradientCard({Key key, this.data}) : super(key: key);
  @override
  _HomeScreenFromGradientCardState createState() => _HomeScreenFromGradientCardState();
}

class _HomeScreenFromGradientCardState extends State<HomeScreenFromGradientCard> {

  String filterValue;

  bool dataLoad = true;

  var topData = [];
  List<StoreModel> bottomData = [];

  getData() async{

    topData = await topStores(widget.data.id);
    topData = topData.where((element) => element['products'].length > 0).toList();
    bottomData = await bottomStores(widget.data.id);
    setState(() {
      dataLoad = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  int limit = 2;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        titleSpacing: 0,
        title: Text('${widget.data.name}', style: AppConst.appbarTextStyle,),
        actions: [
          Icon(Icons.search, size: 20,),
          SizedBox(width: 20),
          GestureDetector(
              onTap: (){
                Get.to(()=> ManageAddressScreen(switchLocation: true));
              },
              child: Icon(FeatherIcons.mapPin, size: 16,)),
          SizedBox(width: 20)
        ],
      ),


      body: dataLoad ? Center(child: SpinKitDualRing(color: AppConst.themePurple)) : Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: topData.length > limit ? limit : topData.length,
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
              itemBuilder: (_, index) {
                final data = topData[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Transform.scale(scale: .5, child: CircleImageWidget(image: data['logo'])),
                        SizedBox(width: 8),
                        Text(
                          data['name']
                        )
                      ],
                    ),

                    SizedBox(height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 12),
                      itemCount: data['products'].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index){
                        final product = data['products'][index];

                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 3,
                                  child: Container(
                                    width: 95,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    padding: EdgeInsets.all(4),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(product['logo']),
                                            fit: BoxFit.contain
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product['name'],
                                      style: TextStyle(
                                        fontSize: 16
                                      ),
                                    ),
                                    Text(
                                      '10\$ Cashback',
                                      style: AppConst.descriptionTextRed,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),)
                  ],
                );
              }
            ),
          ),
          if(topData.length > 6 )Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomOutlineButton(
                  onTap: (){
                    setState(() {
                      limit = 6;
                    });
                  },
                  // label: 'View all Stores (${topData.length})',
                  label: 'View all Stores (6)',
                  height: 28,
                  width: 160,
                  fontStyle: TextStyle(fontSize: 12, fontFamily: 'Stag'),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('All restaurants near you', style: AppConst.header2,),
                      DropDownIcon(
                        onPress: (){
                          Get.bottomSheet(Stack(
                            children: [
                              Container(
                                height: Get.height * .35,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12)
                                    )
                                ),
                                child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) _setState) {

                                  onChanged(value){
                                    _setState((){
                                      filterValue = value;
                                    });
                                  }
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                                        child: Text(
                                            'Sort by',
                                            style: AppConst.titleText2
                                        ),
                                      ),
                                      SizedBox(height: 12),

                                      SizedBox(
                                        height: 40,
                                        child: RadioListTile(
                                          value: 'distance',
                                          groupValue: filterValue,
                                          onChanged: onChanged,
                                          contentPadding: EdgeInsets.only(left: 8),
                                          activeColor: AppConst.themePurple,
                                          title: Text(
                                              'Distance'
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        child: RadioListTile(
                                          value: 'cashback',
                                          groupValue: filterValue,
                                          onChanged: onChanged,
                                          contentPadding: EdgeInsets.only(left: 8),
                                          activeColor: AppConst.themePurple,
                                          title: Text(
                                              'Cashback'
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        child: RadioListTile(
                                          value: 'az',
                                          groupValue: filterValue,
                                          onChanged: onChanged,
                                          contentPadding: EdgeInsets.only(left: 8),
                                          activeColor: AppConst.themePurple,
                                          title: Text(
                                              'A-Z'
                                          ),
                                        ),
                                      ),

                                      Spacer(),
                                      Center(
                                        child: GradientButton(
                                          height: 45,
                                          width: Get.width * .9,
                                          onTap: (){

                                            setState(() {
                                              if(filterValue == 'distance'){
                                                bottomData.sort((a,b) => a.calculated_distance.compareTo(b.calculated_distance));
                                              }else if(filterValue == 'cashback'){
                                                bottomData.sort((a,b) => a.defaultCashback.compareTo(b.defaultCashback));
                                              }else if(filterValue == 'az'){
                                                bottomData.sort((a,b) => a.name.compareTo(b.name));
                                              }
                                            });

                                            Get.back();

                                          },
                                          label: 'Done',
                                          fontStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                    ],
                                  );
                                },),
                              ),

                              Positioned(
                                right: 0,
                                child: CloseButton(),
                              )
                            ],
                          ));
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(height: 20,),
                ),
                Container(
                  child: Expanded(
                      child: ListView.builder(
                          itemCount: bottomData.length,
                          itemBuilder: (BuildContext context, int index){
                            StoreModel store = bottomData[index];
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  StoreShopNowTile(title: store.name, image: store.logo,subtitle: store.promotionCashbackStatus == 'active' && store.promotionCashbackDate.startDate.isAfter(DateTime.now()) && store.promotionCashbackDate.endDate.isBefore(DateTime.now()) ? '${store.promotionCashback} % Cashback' : null,),
                                  Divider(height: 20,)
                                ],
                              ),
                            );
                          }
                      )
                  ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}


Future topStores(String bType) async{
  final query = r'''
  query($bType: ID $lat: Float $lng: Float ){
  getBusinessTypesPageData(businesstype: $bType lat: $lat lng: $lng){
    error
    msg
    data{
      _id
      name
      logo
      promotion_cashback
      promotion_cashback_date{
        start_date
        end_date
      }
      default_cashback
      promotion_cashback_status
      products{
        _id
        name
        logo
      }
    }
  }
}
  ''';

  final variables = {
    'bType' : bType,
    'lat' : UserViewModel.currentLocation.value.latitude,
    'lng' : UserViewModel.currentLocation.value.longitude
  };

  try{
    GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
    QueryResult result = await client.query(QueryOptions(document: gql(query),variables: variables));
    final data = result.data['getBusinessTypesPageData']['data'];
    return data;
  }catch(e){
    print(e.toString());
    return [];
  }

}

Future<List<StoreModel>> bottomStores(String bType) async{
  final query = r'''
query($bType: ID $lat: Float $lng: Float ){
  getBusinessTypesPageNearMeStoresData(businesstype: $bType lat: $lat lng: $lng){
    error
    msg
    data{
      _id
      name
      logo
      promotion_cashback
      promotion_cashback_date{
        start_date
        end_date
      }
      default_cashback
      promotion_cashback_status
      calculated_distance
    }
  }
}
  ''';

  final variables = {
    'bType' : bType,
    'lat' : UserViewModel.currentLocation.value.latitude,
    'lng' : UserViewModel.currentLocation.value.longitude
  };

  try{
    GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
    QueryResult result = await client.query(QueryOptions(document: gql(query),variables: variables));
    List<StoreModel> data = List.from(result.data['getBusinessTypesPageNearMeStoresData']['data'].map((type)=>StoreModel.fromJson(type)));

    return data;
  }catch(e){
    print(e.toString());
    return [];
  }

}