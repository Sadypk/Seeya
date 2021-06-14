
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/order_online/view/store_view.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/newMainAPIs.dart';

class RedeemOnline extends StatefulWidget {
  final List<StoreData> redeemOnlineStores ;
  RedeemOnline({@required this.redeemOnlineStores});
  @override
  _RedeemOnlineState createState() => _RedeemOnlineState();
}

class _RedeemOnlineState extends State<RedeemOnline> {

  @override
  Widget build(BuildContext context) {
    return widget.redeemOnlineStores.isEmpty?Container(
      margin: EdgeInsets.only(left: 20),
      child: Text(
        'No Store Found',
        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ):ListView.separated(
        padding: EdgeInsets.only(bottom: 20,left: 20,right: 20 ),
        primary: false,
        shrinkWrap: true,
        itemCount: widget.redeemOnlineStores.length,
        itemBuilder: (_, index) {
          StoreData searchResult =  widget.redeemOnlineStores[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              onTap: (){
                Get.to(() => StoreView(storeData: searchResult));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: Offset(0, 2), // changes position of shadow
                                ),
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    searchResult.logo,
                                  )
                              )
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              searchResult.name,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${searchResult.defaultCashbackOffer.toString()}% Cashback',
                              style: TextStyle(fontSize: 12,color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${searchResult.customer_wallet_amount} ₹',
                          style: TextStyle(fontSize: 16,color: AppConst.themePurple),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'You earned ${searchResult.customer_wallet_amount} ₹',
                          style: TextStyle(fontSize: 12,color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }, separatorBuilder: (BuildContext context, int index) {
      return Divider(color: Colors.grey.withOpacity(0.5),);
    },);
  }
}
