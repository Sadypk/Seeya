import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/scan_receipt/theBoss/view/cameraView.dart';
import 'package:seeya/features/scan_receipt/view/41_scan_specific_receipts.dart';
import 'package:seeya/features/settings/view/21_manage_address.dart';
import 'package:seeya/main_app/models/businessTypes.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';
import 'package:seeya/newMainAPIs.dart';

import '55_scan_receipts.dart';

class ScanYourReceipt extends StatefulWidget {
  @override
  _ScanYourReceiptState createState() => _ScanYourReceiptState();
}

class _ScanYourReceiptState extends State<ScanYourReceipt> {
  List<BoomModel> favStores = [];
  List<BoomModel> nearStores = [];
  List<BusinessType> typesData = [];
  Widget customTile(BusinessType bType){
    return InkWell(
      onTap: (){
        Get.to(() => ScanSpecificReceipt(bType: bType));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleImageWidget(image: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660'),
              SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bType.name, style: TextStyle(fontSize: 22, fontFamily: 'Stag', ),),
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
              child: Text("${bType.count}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: AppConst.themePurple, fontFamily: 'Stag'),),
            ),
          )
        ],
      ),
    );
  }

  bool dataLoading = true;
  getData() async{
    favStores = await NewApi.scanReceiptsBannerFavStores();
    nearStores = await NewApi.scanReceiptBannerNearMeStoreData();
    typesData = await NewApi.scanReceiptCategoryCountData();
    setState(() {
      dataLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }


  String filterValue = 'distance';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Scan your receipt', style: AppConst.appbarTextStyle,),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Icon(Icons.search, size: 20,),
          SizedBox(width: 20,),
          GestureDetector(
            onTap: (){
              Get.to(()=> ManageAddressScreen(switchLocation: true));
            },
            child: Icon(FeatherIcons.mapPin, size: 16,)),
          SizedBox(width: 20,),
        ],
      ),
      body: dataLoading ? SpinKitDualRing(color: AppConst.themePurple) : DefaultTabController(
        length: 2,
        child: Container(
          child: ListView(
            children: [
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GradientButton(
                  onTap: () => Get.to(() => ScanReceipts()),
                  height: 40,
                  label: 'Upload receipts',
                  fontStyle: AppConst.descriptionTextWhite2,
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(color: Colors.grey[200], thickness: 1,),
              ),
              Wrap(
                children: typesData.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      customTile(e),
                      Divider(color: Colors.grey[200], thickness: 1, height: 20,),
                    ],
                  ),
                )).toList(),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Stores offering cashback', style: AppConst.header2,),
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
                                              favStores.sort((a,b) => a.calculated_distance.compareTo(b.calculated_distance));
                                              nearStores.sort((a,b) => a.calculated_distance.compareTo(b.calculated_distance));
                                            }else if(filterValue == 'cashback'){
                                              favStores.sort((a,b) => a.defaultCashbackOffer.compareTo(b.defaultCashbackOffer));
                                              nearStores.sort((a,b) => a.defaultCashbackOffer.compareTo(b.defaultCashbackOffer));
                                            }else if(filterValue == 'az'){
                                              favStores.sort((a,b) => a.name.compareTo(b.name));
                                              nearStores.sort((a,b) => a.name.compareTo(b.name));
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
                child: Divider(color: Colors.grey[200], thickness: 1,),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TabBar(
                  labelColor: Colors.black,
                  labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3, color: Color(0xff9D239A)),
                  unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3, color: Colors.black54),
                  indicatorColor: AppConst.themePurple,
                  tabs: [
                    Tab(text: 'My Favourites'),
                    Tab(text: 'Near me',)
                  ],
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 500,
                child: TabBarView(
                  children: [
                    BauBau(data: favStores),
                    BauBau(data: nearStores)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

class BauBau extends StatelessWidget {
  final List<BoomModel> data;
  const BauBau({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.length > 0 ? ListView.builder(
        itemCount: data.length,
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (BuildContext context, int index){
          BoomModel _store = data[index];
          return GestureDetector(
            onTap: (){
              Get.to(() => TheBossCameraScreen(storeModel: _store));
            },
            child: Column(
              children: [
                StoreShopNowTile(title: _store.name, image: _store.logo),
                Divider(color: Colors.grey[200], thickness: 1, height: 20,),
              ],
            ),
          );
        }
    ) : Center(child: Text('None available'));
  }
}

class DropDownIcon extends StatelessWidget {

  final onPress;

  const DropDownIcon({Key key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: Row(
          children: [
            Text('Sort by', style: AppConst.descriptionText,),
            Icon(
              Icons.arrow_drop_down
            )
          ],
        ),
      ),
    );
  }
}
