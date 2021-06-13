import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/scan_receipt/view/40_scan_your_receipt.dart';
import 'package:seeya/features/scan_receipt/view/42_scan_grocery_receipts_by_categories.dart';
import 'package:seeya/features/scan_receipt/view/43_stores_with_category_offers.dart';
import 'package:seeya/features/settings/view/21_manage_address.dart';
import 'package:seeya/main_app/models/45_model.dart';
import 'package:seeya/main_app/models/businessTypes.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';
import 'package:seeya/main_app/view/widgets/square_image_widget.dart';
import 'package:seeya/newMainAPIs.dart';

import '55_scan_receipts.dart';

class ScanSpecificReceipt extends StatefulWidget {
  final BusinessType bType;
  ScanSpecificReceipt({this.bType});
  @override
  _ScanSpecificReceiptState createState() => _ScanSpecificReceiptState();
}

class _ScanSpecificReceiptState extends State<ScanSpecificReceipt> {
  List<CatalogModel> catalogs = [];
  List<StoreData> favStores = [];
  List<StoreData> nearStores = [];
  getData() async{
    catalogs = await NewApi.getCatalogByBusinessID(widget.bType.id);
    favStores = await NewApi.scanReceiptsBannerFavStores(bType: widget.bType.id);
    nearStores = await NewApi.scanReceiptBannerNearMeStoreData(bType: widget.bType.id);
    setState(() {
      dataLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  bool dataLoading = true;

  String filterValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Scan ${widget.bType.name} receipt', style: AppConst.appbarTextStyle,),
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
        child: ListView(
          children: [
            // SizedBox(height: 25,),
            Container(
              height: 105,
              child: ListView.builder(
                  itemCount: catalogs.length,
                  padding: EdgeInsets.only(left: 20),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      onTap: (){
                        Get.to(() =>ScanGroceryReceiptsByCategories(cType: catalogs[index]));
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 16, top: 25, bottom: 25),
                          child: SquareImageWidget(
                            image: catalogs[index].img,
                            title: catalogs[index].name,
                          )),
                    );
                  })
            ),
            // SizedBox(height: 25,),
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
            Divider(color: Colors.grey[200], thickness: 1, height: 20,),
            SizedBox(height: 15,),
            TabBar(
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3, color: Color(0xff9D239A)),
              unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3, color: Colors.black54),
              indicatorColor: AppConst.themePurple,
              tabs: [
                Tab(text: 'My Favourites'),
                Tab(text: 'Near me',)
              ],
            ),
            SizedBox(height: 10,),
            Container(
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
    );
  }
}
