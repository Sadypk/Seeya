import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seeya/features/order_online/view/order_details.dart';
import 'package:seeya/main_app/config/localStorage.dart';
import 'package:seeya/main_app/models/addressModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/newMainAPIs.dart';

class CartPage extends StatefulWidget {
  final BoomModel data;

  const CartPage({Key key, this.data}) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  int quantity = 1;
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
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16)),
                          Text(
                              '(${widget.data.defaultCashbackOffer}% cashback)',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 11)),
                        ],
                      ),
                      Text(
                        '....',
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
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(Icons.sticky_note_2_outlined,
                              color: AppConst.themePurple,),
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(Icons.phone_outlined,
                              color: AppConst.themePurple,),
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(Icons.message_outlined,
                              color: AppConst.themePurple,),
                          )
                      ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey.withOpacity(0.5)),
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
                          Text('Gains & Bread',style: TextStyle(fontSize: 16),),
                          Text('10% cashBack',style: TextStyle(fontSize: 14,color: Colors.red),),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all()
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  quantity--;
                                });

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.transparent)
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16),

                                child: Text('-',style: TextStyle(fontSize: 22),),
                              ),
                            ),
                            Text('$quantity',style: TextStyle(fontSize: 16),),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent)
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16),

                                  child: Text('+',style: TextStyle(fontSize: 22),),
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: Text('Amount',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey.withOpacity(0.5)),
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
                          Text('Gains & Bread',style: TextStyle(fontSize: 16),),
                          Text('10% cashBack',style: TextStyle(fontSize: 14,color: Colors.red),),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all()
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  quantity--;
                                });

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.transparent)
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16),

                                child: Text('-',style: TextStyle(fontSize: 22),),
                              ),
                            ),
                            Text('$quantity',style: TextStyle(fontSize: 16),),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.transparent)
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16),

                                child: Text('+',style: TextStyle(fontSize: 22),),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 122,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200,width: 1),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0,12),
                      blurRadius: 12,
                      color: Colors.grey.shade200
                  )
                ],
                borderRadius: BorderRadius.circular(4)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(FeatherIcons.mapPin, color: AppConst.themePurple, size: 16,),
                SizedBox(width: 5,),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${UserViewModel.user.value.addresses[UserViewModel.locationIndex.value].title.trim().capitalize}', style: AppConst.titleText1_2),
                      SizedBox(height: 3,),
                      Text('${UserViewModel.user.value.addresses[UserViewModel.locationIndex.value].address.trim().capitalize}',
                        style: AppConst.descriptionTextOpen,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('Edit', style: TextStyle(fontFamily: 'Stag', fontSize: 14, decoration: TextDecoration.underline, color: AppConst.themePurple),),
                          SizedBox(width: 30,),
                          GestureDetector(
                              onTap: () async{

                              },
                              child: Text('Delete', style: TextStyle(fontFamily: 'Stag', fontSize: 14, decoration: TextDecoration.underline, color: AppConst.themePurple),))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          GestureDetector(
            onTap: (){
              Get.to(()=>OrderDetails(data: widget.data,));
            },
            child: Container(
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
                    Text('Added to Cart(0 items)',
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                    Text('View Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
