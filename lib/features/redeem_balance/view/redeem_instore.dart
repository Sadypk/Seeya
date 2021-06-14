import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/order_online/repo/confirm_order_repo.dart';
import 'package:seeya/home.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/util/snack.dart';
import 'package:seeya/newMainAPIs.dart';

class RedeemInStore extends StatefulWidget {
  final List<StoreData> redeemInStores;

  RedeemInStore({@required this.redeemInStores});

  @override
  _RedeemInStoreState createState() => _RedeemInStoreState();
}

class _RedeemInStoreState extends State<RedeemInStore> {
  int selectedRedeemValue = 0;

  @override
  Widget build(BuildContext context) {
    return widget.redeemInStores.isEmpty?Container(
      margin: EdgeInsets.only(left: 20),
      child: Text(
        'No Store Found',
        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ):ListView.separated(
      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      primary: false,
      shrinkWrap: true,
      itemCount: widget.redeemInStores.length,
      itemBuilder: (_, index) {
        StoreData searchResult = widget.redeemInStores[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () async {
              selectedRedeemValue = searchResult.customer_wallet_amount;

              Get.bottomSheet(
                  StatefulBuilder(
                    builder: (context, _setState) {
                      return  Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
                            boxShadow: [AppConst.shadowBottomNavBar]),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width,
                              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Amount',
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      onPressed: () => Get.back(),
                                      icon: Icon(Icons.close_rounded),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  searchResult.name,
                                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  searchResult.address.address,
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Wallet balance:',
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    ),
                                    Text(
                                      ' ${searchResult.customer_wallet_amount} ₹',
                                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Center(
                                  child: Text(
                                    ' $selectedRedeemValue ₹',
                                    style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Slider(
                                    value: selectedRedeemValue.toDouble(),
                                    min: 0,
                                    max: searchResult.customer_wallet_amount.toDouble(),
                                    inactiveColor: Colors.grey,
                                    activeColor: AppConst.themePurple,
                                    onChanged: (double newValue) {
                                      _setState(() {
                                        selectedRedeemValue = newValue.round();
                                      });
                                    },
                                    semanticFormatterCallback: (double newValue) {
                                      return '${newValue.round()} ₹';
                                    }),

                                SizedBox(
                                  height: 50,
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () async {
                                bool error = await ConfirmOrderRepo.placeOrder(
                                    images: null,
                                    total: 0,
                                    store: widget.redeemInStores[index],
                                    products: [],
                                    rawItem: [],
                                    order_type: "redeem_cash",
                                    wallet_amount: selectedRedeemValue);
                                if (error) {
                                  Snack.bottom('Error', 'Failed to send order');
                                } else {
                                  await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Confirmed"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Redeemed $selectedRedeemValue Successfully"),
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              // Get.offAll(() => Home());
                                              Get.back();
                                              Get.back();
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(color: AppConst.themePurple, borderRadius: BorderRadius.circular(4)),
                                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 14)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  isDismissible: false,
                  isScrollControlled: true,
                  enableDrag: false);
            },
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
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
                                ))),
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
                            style: TextStyle(fontSize: 12, color: Colors.red),
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
                        style: TextStyle(fontSize: 16, color: AppConst.themePurple),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'You earned ${searchResult.customer_wallet_amount} ₹',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey.withOpacity(0.5),
        );
      },
    );
  }
}
