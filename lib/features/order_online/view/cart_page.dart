import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:seeya/features/order_online/repo/confirm_order_repo.dart';
import 'package:seeya/features/order_online/view/order_details.dart';
import 'package:seeya/features/order_online/view/store_view.dart';
import 'package:seeya/features/scan_receipt/view/purchased_products_screen.dart';
import 'package:seeya/features/settings/view/21_manage_address.dart';
import 'package:seeya/main_app/models/productModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/user/viewModel/cartModel.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/main_app/util/custom_dialog.dart';
import 'package:seeya/main_app/util/over_scroll.dart';
import 'package:seeya/main_app/util/snack.dart';
import 'package:seeya/newMainAPIs.dart';

class CartPage extends StatefulWidget {
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
                          Text(CartItemModel.selectedStore.isNotEmpty ? '${CartItemModel.selectedStore[0].name}' : '',
                              style:
                              TextStyle(color: Colors.white, fontSize: 16)),
                          Text(
                              CartItemModel.selectedStore.isNotEmpty ? '(${CartItemModel.selectedStore[0].defaultCashbackOffer}% cashback)' : '',
                              style:
                              TextStyle(color: Colors.white, fontSize: 11)),
                        ],
                      ),
                      Text(CartItemModel.selectedStore.isNotEmpty ? '(${CartItemModel.selectedStore[0].store_type})' : '',
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
          CartItemModel.selectedStore.isNotEmpty ?GestureDetector(
            onTap: (){
              Get.to(() => StoreView(storeData: CartItemModel.selectedStore[0]));
            },
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                    borderRadius: BorderRadius.circular(4)),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Add more products',
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ),
                ),
            ),
          ):SizedBox(),
          CartItemModel.selectedStore.isNotEmpty ?Row(
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
                'Claim ${CartItemModel.walletAmount.value} from your wallet',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ):SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: CartItemModel.rawItem.length,
                  itemBuilder: (_, index) {
                    RawProduct item = CartItemModel.rawItem[index];
                    return Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                                        } else {
                                          var dialog = CustomAlertDialog(
                                              title: "Remove Item",
                                              message: "Are you sure, do you remove this item?",
                                              onPostivePressed: () {
                                                setState(() {
                                                  CartItemModel.rawItem.remove(item);
                                                  if(CartItemModel.rawItem.isEmpty){
                                                    CartItemModel.selectedStore.clear();
                                                    CartItemModel.walletAmount.value = 0;
                                                  }
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
                    CartItemModel.products.length == 0 && CartItemModel.products.length == 0 ? 'Cart is empty' : 'Amount',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )),
              ListView.builder(
                shrinkWrap: true,
                itemCount: CartItemModel.products.length,
                itemBuilder: (_, index) {
                  ProductModel item = CartItemModel.products[index];
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
                                      else {
                                        var dialog = CustomAlertDialog(
                                            title: "Remove Item",
                                            message: "Are you sure, do you remove this item?",
                                            onPostivePressed: () {
                                              setState(() {
                                                CartItemModel.products.remove(item);
                                                if(CartItemModel.products.isEmpty){
                                                  CartItemModel.selectedStore.clear();
                                                  CartItemModel.walletAmount.value = 0;
                                                }
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
                              '${UserViewModel.user.value.addresses[UserViewModel.locationIndex.value].title
                                  .trim()
                                  .capitalize}',
                              style: AppConst.titleText1_2),
                          GestureDetector(
                            onTap: () async {
                              var res = await Get.to(() =>
                                  ManageAddressScreen(
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
                        '${UserViewModel.user.value.addresses[UserViewModel.locationIndex.value].address
                            .trim()
                            .capitalize}',
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
                      'Added to Cart (${CartItemModel.rawItem.length + CartItemModel.products.length} items)',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  GestureDetector(
                    onTap: () async {
                      Get.bottomSheet(
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    topLeft: Radius.circular(12)),
                                boxShadow: [AppConst.shadowBottomNavBar]),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: OverScroll(
                                    child: ListView(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      children: [
                                        ListTile(
                                          onTap: () {},
                                          title: RichText(
                                            text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Selected Items list',
                                                    style: TextStyle(fontFamily: 'open', fontSize: 14, fontWeight: FontWeight.w600, color: AppConst.themePurple),),
                                                  TextSpan(
                                                    text: ' without any payment',
                                                    style: TextStyle(fontFamily: 'open', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),),
                                                ]
                                            ),

                                          ),
                                          leading: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  AppConst.shadowBasic
                                                ],
                                                color: Colors.white,
                                                border: Border.all(color: Color(0xff707070), width: 0.01)
                                            ),
                                            child: Center(
                                              child: Image.asset('assets/images/cart-button1.png'),
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () {},
                                          title: RichText(
                                            text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Just verify your list',
                                                    style: TextStyle(fontFamily: 'open', fontSize: 14, fontWeight: FontWeight.w600, color: AppConst.themePurple),),
                                                  TextSpan(
                                                    text: ' and call you if required',
                                                    style: TextStyle(fontFamily: 'open', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),),
                                                ]
                                            ),

                                          ),
                                          leading: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  AppConst.shadowBasic
                                                ],
                                                color: Colors.white,
                                                border: Border.all(color: Color(0xff707070), width: 0.01)
                                            ),
                                            child: Center(
                                              child: Image.asset('assets/images/cart-button2.png'),
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () {},
                                          title: RichText(
                                            text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Pay requested amount',
                                                    style: TextStyle(fontFamily: 'open', fontSize: 14, fontWeight: FontWeight.w600, color: AppConst.themePurple),),
                                                  TextSpan(
                                                    text: ' after order confirmation using Razorpay',
                                                    style: TextStyle(fontFamily: 'open', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),),
                                                ]
                                            ),

                                          ),
                                          leading: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  AppConst.shadowBasic
                                                ],
                                                color: Colors.white,
                                                border: Border.all(color: Color(0xff707070), width: 0.01)
                                            ),
                                            child: Center(
                                              child: Image.asset('assets/images/cart-button3.png'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                GestureDetector(
                                  onTap: () async {
                                    if (CartItemModel.rawItem.length == 0 && CartItemModel.products.length == 0) {
                                      double total = 0;
                                      CartItemModel.products.forEach((element) {
                                        total += element.sellingPrice * element.quantity;
                                      });
                                      bool error = await ConfirmOrderRepo.placeOrder(
                                          images: null,
                                          total: double.parse(total.toStringAsFixed(2)),
                                          store: CartItemModel.selectedStore[0],
                                          products: CartItemModel.products,
                                          rawItem: CartItemModel.rawItem,
                                          order_type: CartItemModel.selectedStore[0].store_type,
                                          wallet_amount: checkBoxValue.value ? CartItemModel.walletAmount.value : 0
                                      );
                                      if (error) {
                                        Snack.bottom('Error', 'Failed to send order');
                                      } else {
                                        Get.offAll(() => OrderDetails());
                                        Snack.top('Confirmed', 'Order Sent Successfully');
                                      }
                                    } else {
                                      Snack.bottom('Empty Cart', 'No item to order');
                                    }
                                  },
                                  child: Container(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        color: AppConst.themePurple,
                                        borderRadius: BorderRadius.circular(4)),
                                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                            'Agree and place order',
                                            style: TextStyle(color: Colors.white, fontSize: 14)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                              ],
                            ),
                          )
                      );
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
