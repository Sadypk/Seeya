import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/home.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/user/viewModel/cartModel.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool customerLocations = false;

  @override
  Widget build(BuildContext context) {
    int totalItems = 0;
    CartItemModel.rawItem.forEach((element) {
      totalItems += element.quantity;
    });
    CartItemModel.products.forEach((element) {
      totalItems += element.quantity;
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.only(right: 10),
              onPressed: () {
                CartItemModel.rawItem.clear();
                CartItemModel.products.clear();
                CartItemModel.selectedStore.clear();
                CartItemModel.walletAmount.value = 0;
                Get.offAll(() => Home());
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('${CartItemModel.selectedStore[0].name}',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    Text('(${CartItemModel.selectedStore[0].defaultCashbackOffer}% cashback)',
                        style: TextStyle(color: Colors.white, fontSize: 11)),
                  ],
                ),
                Text('${CartItemModel.selectedStore[0].store_type}',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 25,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff707070).withOpacity(0.3)),
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(offset: Offset(0.1, 0.1), color: Colors.grey)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Merchant will review your order soon',
                      style: TextStyle(
                          color: AppConst.themePurple,
                          fontSize: 14,
                          fontFamily: 'Stag')),
                ])),
                Text(
                  'Usually within 30min',
                  style: TextStyle(
                      fontSize: 10, color: AppConst.black, fontFamily: 'open'),
                ),
                Text(
                  'Please call to check yout items available',
                  style: TextStyle(
                      fontSize: 10, color: AppConst.black, fontFamily: 'open'),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '*We guarantee you can save 100 from this order',
                      style: TextStyle(
                          color: AppConst.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff707070).withOpacity(0.3)),
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(offset: Offset(0.1, 0.1), color: Colors.grey)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Order ID: ',
                      style: TextStyle(
                          color: Color(0xff252525),
                          fontSize: 14,
                          fontFamily: 'Stag')),
                  TextSpan(
                      text: '#GP2601596',
                      style: TextStyle(
                          color: AppConst.themePurple,
                          fontSize: 14,
                          fontFamily: 'Stag')),
                ])),
                Text(
                  '21 March 2021',
                  style: TextStyle(
                      fontSize: 10, color: AppConst.black, fontFamily: 'open'),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup from: ',
                      style: TextStyle(
                          color: AppConst.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                        child: Text(
                            '${UserViewModel.user.value.addresses[UserViewModel.locationIndex.value].address}',
                            style:
                                TextStyle(color: AppConst.black, fontSize: 10)))
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xff707070).withOpacity(0.25))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Call merchants for any concerns',
                  style: AppConst.header,
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppConst.themePurple),
                  child: Center(
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xff707070).withOpacity(0.25))),
            child: Column(
              children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Call merchants for any concerns',
                        style: AppConst.header,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConst.themePurple),
                        child: Center(
                          child: Icon(
                            Icons.message,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xff707070).withOpacity(0.25),
                  height: 0,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Center(
                      child: Container(
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff707070).withOpacity(.25)),
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0xffC4C4C4).withOpacity(0.3)),
                        child: Row(
                          children: [
                            Flexible(
                                child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Center(
                                child: TextFormField(
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Start typing',
                                      hintStyle: TextStyle(
                                          fontSize: 10, fontFamily: 'open')),
                                ),
                              ),
                            )),
                            VerticalDivider(
                              color: Color(0xff707070).withOpacity(.25),
                              thickness: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child:
                                  Image.asset('assets/images/arrow_right.png'),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff707070).withOpacity(.25)),
                borderRadius: BorderRadius.circular(4)),
            child: ExpansionTileCard(
              title: Text(
                'Your Orders $totalItems items',
                style: TextStyle(
                    fontSize: 14, fontFamily: 'Stag', color: AppConst.black),
              ),
              elevation: 0.1,
              borderRadius: BorderRadius.circular(4),
              children: [
                Divider(
                  height: 1,
                  color: Color(0xff707070).withOpacity(0.25),
                  thickness: 1,
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: CartItemModel.rawItem.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 25,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          color: index % 2 != 0
                              ? Color(0xffC4C4C4).withOpacity(0.2)
                              : Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                CartItemModel.rawItem[index].name,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Stag',
                                    color: AppConst.black),
                              ),
                              Text(
                                'x${CartItemModel.rawItem[index].quantity}',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Stag',
                                    color: AppConst.black),
                              )
                            ],
                          ),
                        );
                      }),
                ),
                Divider(
                  height: 1,
                  color: Color(0xff707070).withOpacity(0.25),
                  thickness: 1,
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: CartItemModel.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 25,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          color: index % 2 != 0
                              ? Color(0xffC4C4C4).withOpacity(0.2)
                              : Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                CartItemModel.products[index].name,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Stag',
                                    color: AppConst.black),
                              ),
                              Text(
                                'x${CartItemModel.products[index].quantity}',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Stag',
                                    color: AppConst.black),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xff707070).withOpacity(0.25))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Opt-in for contactless delivery',
                  style: AppConst.header,
                ),
                Checkbox(
                  value: customerLocations,
                  onChanged: (v) {
                    setState(() {
                      customerLocations = v;
                    });
                  },
                  checkColor: AppConst.themePurple,
                  activeColor: Colors.white,
                  focusColor: AppConst.themePurple,
                  hoverColor: AppConst.themePurple,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xff707070).withOpacity(0.25))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cancel your order',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Stag',
                      letterSpacing: 0.3,
                      color: Color(0xffEE175B),
                    )),
                SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
