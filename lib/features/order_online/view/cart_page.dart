import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:seeya/features/order_online/repo/confirm_order_repo.dart';
import 'package:seeya/features/order_online/view/order_details.dart';
import 'package:seeya/features/scan_receipt/view/purchased_products_screen.dart';
import 'package:seeya/features/settings/view/21_manage_address.dart';
import 'package:seeya/main_app/models/productModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/main_app/util/custom_dialog.dart';
import 'package:seeya/main_app/util/snack.dart';
import 'package:seeya/newMainAPIs.dart';

class CartPage extends StatefulWidget {
  final BoomModel data;
  final StoreData storeData;

  const CartPage({Key key, this.data, this.storeData}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  RxBool checkBoxValue = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.only(right: 10),
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${widget.data.name}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          Text(
                              '(${widget.data.defaultCashbackOffer}% cashback)',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11)),
                        ],
                      ),
                      Text('....',
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.sticky_note_2_outlined,
                          color: AppConst.themePurple,
                        ),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.phone_outlined,
                          color: AppConst.themePurple,
                        ),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.message_outlined,
                          color: AppConst.themePurple,
                        ),
                      )),
                    ),
                  ),
                ],
              )
            ],
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: <Widget>[
              SizedBox(
                width: 8,
              ),
              Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                checkColor: AppConst.themePurple,
                activeColor: Colors.white,
                focusColor: AppConst.themePurple,
                hoverColor: AppConst.themePurple,
                value: checkBoxValue.value,
                onChanged: (bool value) {
                  setState(() {
                    checkBoxValue.value = value;
                  });
                },
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                'Claim ${widget.storeData.walletAmount} from your wallet',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: PurchasedProductsScreen.rawItem.length,
                  itemBuilder: (_, index) {
                    RawProduct item = PurchasedProductsScreen.rawItem[index];
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1.0, color: Colors.grey.withOpacity(0.5)),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(border: Border.all()),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (item.quantity != 1) {
                                          item.quantity--;
                                        }else{
                                          var dialog = CustomAlertDialog(
                                              title: "Remove Item",
                                              message: "Are you sure, do you remove this item?",
                                              onPostivePressed: () {
                                                setState(() {
                                                  PurchasedProductsScreen.rawItem.remove(item);
                                                  Get.back();
                                                });
                                              },
                                              positiveBtnText: 'Yes',
                                              negativeBtnText: 'No');

                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) => dialog);
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(
                                        '-',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${item.quantity}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        item.quantity++;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(
                                        '+',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: Text(
                    PurchasedProductsScreen.products.length == 0 && PurchasedProductsScreen.products.length == 0?'Cart is empty':'Amount',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )),
              ListView.builder(
                shrinkWrap: true,
                itemCount: PurchasedProductsScreen.products.length,
                itemBuilder: (_, index) {
                  ProductModel item = PurchasedProductsScreen.products[index];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: 1.0, color: Colors.grey.withOpacity(0.5)),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${item.cashbackPercentage}% cashBack',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.red),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                   setState(() {
                                     if (item.quantity != 1) {
                                       item.quantity--;
                                     }
                                     else{
                                       var dialog = CustomAlertDialog(
                                           title: "Remove Item",
                                           message: "Are you sure, do you remove this item?",
                                           onPostivePressed: () {
                                             setState(() {
                                               PurchasedProductsScreen.products.remove(item);
                                               Get.back();
                                             });

                                           },
                                           positiveBtnText: 'Yes',
                                           negativeBtnText: 'No');

                                       showDialog(
                                           context: context,
                                           builder: (BuildContext context) => dialog);
                                     }
                                   });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.transparent)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      '-',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ),
                                ),
                                Text(
                                  item.quantity.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      item.quantity++;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.transparent)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      '+',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Container(
            height: 90,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200, width: 1),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 12),
                      blurRadius: 12,
                      color: Colors.grey.shade200)
                ],
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  FeatherIcons.mapPin,
                  color: AppConst.themePurple,
                  size: 16,
                ),
                SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${UserViewModel.user.value.addresses[UserViewModel.locationIndex.value].title.trim().capitalize}',
                              style: AppConst.titleText1_2),
                          GestureDetector(
                            onTap: () async {
                              var res = await Get.to(() => ManageAddressScreen(
                                    switchLocation: true,
                                  ));
                              if (res) {
                                setState(() {});
                              }
                            },
                            child: Text(
                              'Change',
                              style: TextStyle(
                                  fontFamily: 'Stag',
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  color: AppConst.themePurple),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        '${UserViewModel.user.value.addresses[UserViewModel.locationIndex.value].address.trim().capitalize}',
                        style: AppConst.descriptionTextOpen,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        '45 mins away',
                        style: TextStyle(
                            fontFamily: 'Stag',
                            fontSize: 14,
                            color: AppConst.themePurple),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: AppConst.themePurple,
                borderRadius: BorderRadius.circular(4)),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Added to Cart (${PurchasedProductsScreen.rawItem.length + PurchasedProductsScreen.products.length} items)',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  GestureDetector(
                    onTap: () async {
                      if(PurchasedProductsScreen.products.length != 0 || PurchasedProductsScreen.products.length != 0){
                        double total = 0;
                        PurchasedProductsScreen.products.forEach((element) {
                          total += element.sellingPrice*element.quantity;
                        });
                        bool error = await ConfirmOrderRepo.placeOrder(
                          images: null,
                          total: double.parse(total.toStringAsFixed(2)),
                          store: widget.data,
                          products: PurchasedProductsScreen.products,
                          rawItem: PurchasedProductsScreen.rawItem,
                          order_type: widget.data.store_type,
                        );
                        if (error) {
                          Snack.bottom('Error', 'Failed to send order');
                        } else {

                          Get.offAll(() => OrderDetails(
                            data: widget.data,
                          ));
                          Snack.top('Confirmed', 'Order Sent Successfully');
                        }
                      }else{
                        Snack.bottom('Empty Cart', 'No item to order');
                      }
                    },
                    child: Text('Confirm Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
