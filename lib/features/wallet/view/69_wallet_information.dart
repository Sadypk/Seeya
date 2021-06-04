import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:seeya/features/near_you/view/71_near_you.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/custom_outline_button.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';

class WalletInformation extends StatefulWidget {
  @override
  _WalletInformationState createState() => _WalletInformationState();
}

class _WalletInformationState extends State<WalletInformation> {
  bool customerLocations = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet information', style: AppConst.appbarTextStyle,),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          SizedBox(height: 25,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: GradientButton(
              onTap: (){
                Get.to(NearYou());
              },
              height: 40,
              label: 'Upload receipt',
              fontStyle: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Stag'),
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Flexible(
                  child: CustomOutlineButton(
                    label: 'Make offer',
                    height: 40,
                    fontStyle: TextStyle(fontFamily: 'open', fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(width: 20,),
                Flexible(
                  child: CustomOutlineButton(
                    label: 'View seller info',
                    height: 40,
                    fontStyle: TextStyle(fontFamily: 'open', fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xff707070).withOpacity(0.3)),
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.1,0.1),
                  color: Colors.grey
                )
              ]
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Order ID: ', style: TextStyle(color: Color(0xff252525), fontSize: 14, fontFamily: 'Stag')),
                    TextSpan(text: '#GP2601596', style: TextStyle(color: AppConst.themePurple, fontSize: 14, fontFamily: 'Stag')),
                  ]
                )),
                Text('21 March 2021', style: TextStyle(fontSize: 10, color: AppConst.black, fontFamily: 'open'),),
                SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pickup from: ', style: TextStyle(color: AppConst.black, fontSize: 10, fontWeight: FontWeight.bold),),
                    Flexible(child: Text('Postmaster, Bangalore City S.O, Bengaluru, Karnataka, India.', style: TextStyle(color: AppConst.black, fontSize: 10)))
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xff707070).withOpacity(0.25))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Call merchants for any concerns', style: AppConst.header,),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConst.themePurple
                  ),
                  child: Center(
                    child: Icon(Icons.call, color: Colors.white, size: 16,),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xff707070).withOpacity(0.25))
            ),
            child: Column(
              children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Call merchants for any concerns', style: AppConst.header,),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConst.themePurple
                        ),
                        child: Center(
                          child: Icon(Icons.message, color: Colors.white, size: 16,),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(color: Color(0xff707070).withOpacity(0.25), height: 0,),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff707070).withOpacity(.25)),
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xffC4C4C4).withOpacity(0.3)
                      ),
                      child: Row(
                        children: [
                          Flexible(child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration.collapsed(hintText: 'Start typing', hintStyle: TextStyle(fontSize: 10, fontFamily: 'open')),
                              ),
                            ),
                          )),
                          VerticalDivider(color: Color(0xff707070).withOpacity(.25), thickness: 0,),
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Image.asset('assets/images/arrow_right.png'),
                          )
                        ],
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xff707070).withOpacity(.25)),
              borderRadius: BorderRadius.circular(4)
            ),
            child: ExpansionTileCard(
              title: Text('Transactions', style: TextStyle(fontSize: 14, fontFamily: 'Stag', color: AppConst.black),),
              elevation: 0.1,
              borderRadius: BorderRadius.circular(4),
              children: [
                Divider(height: 1, color: Color(0xff707070).withOpacity(0.25),thickness: 1,),
                Container(
                  height: 150,
                  child: ListView.builder(
                    itemCount: 20,
                      itemBuilder: (BuildContext context, int index){
                        return Container(
                          height: 25,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          color: index%2!=0?Color(0xffC4C4C4).withOpacity(0.2):Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Bread', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, fontFamily: 'Stag', color: AppConst.black),),
                              Text('X2', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, fontFamily: 'Stag', color: AppConst.black),)
                            ],
                          ),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xff707070).withOpacity(0.25))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Customer locations', style: AppConst.header,),
                Checkbox(value: customerLocations, onChanged: (v){
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
          SizedBox(height: 10,),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xff707070).withOpacity(0.25))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delete transactions', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Stag', letterSpacing: 0.3, color: Color(0xffEE175B),)),
                SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
