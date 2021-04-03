import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:seeya/features/profile_screen/view/profile_edit.dart';
import 'package:seeya/main_app/models/userModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel user;

  @override
  void initState() {
    user = UserViewModel.user.value;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var headerWidget = Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300], width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              offset: Offset(0,1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
          color: Colors.white
      ),
      child: Row(
        children: [
          Container(
            height:54,
            width: 54,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300],
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0.5,0.5)
                  )
                ]
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        color: AppConst.themePurple,
                        shape: BoxShape.circle
                    ),
                    child: Center(
                      child: Icon(Icons.edit_outlined, color: Colors.white, size:9,),
                    ),
                  ),
                ),
                Center(
                  child: Icon(FeatherIcons.smile, color: AppConst.themePurple, size: 35,),
                ),
              ],
            )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ram Ravuri', style: AppConst.titleText2,),
              SizedBox(height: 2,),
              Text('+91 90000 84845', style: AppConst.descriptionText,),
              SizedBox(height: 2,),
              Text('Edit Account', style: AppConst.descriptionTextPurple,),
            ],
          )
        ],
      ),
    );
    var referBanner = Container(
      height: 80,
      width: MediaQuery.of(context).size.width-40,
      padding: EdgeInsets.only(left: 15),
      // margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300],
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0.5,0.5)
            )
          ],
          color: Colors.white,
        image: DecorationImage(
          image: AssetImage(AppConst.referAndEarnImage)
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Refer & Earn', style: TextStyle(color: Color(0xff252525), fontSize: 18, fontFamily: 'Stag', letterSpacing: 0.3),),
          SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('10', style: TextStyle(color: Color(0xff252525), fontSize: 25,fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3, height: 0),),
              Text('₹', style: AppConst.descriptionText,),
              SizedBox(width: 5,),
              Text('Your earnings', style: AppConst.descriptionTextPurple,),
            ],
          )
        ],
      ),
    );
    var lifeTimeCashBack = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lifetime cashback', style: AppConst.titleText1,),
              SizedBox(height: 10,),
              Text('Cashback balance', style: AppConst.descriptionText,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('1,500 ₹', style: AppConst.titleText1Purple,),
              SizedBox(height: 10,),
              Text('250 ₹', style: AppConst.descriptionTextPurple,),
            ],
          )
        ],
      ),
    );
    var manageAddress = Row(children: [Text('Manage Address', style: AppConst.titleText1,),],);
    var myRank = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My rank', style: AppConst.titleText1,),
              SizedBox(height: 10,),
              Text('Check your current ranks', style: AppConst.descriptionText,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [AppConst.shadowBasic]
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.gem,size: 12,color: AppConst.themePurple,))),
              SizedBox(height: 10,),
              Text('Diamond', style: AppConst.descriptionTextPurple,),
            ],
          )
        ],
      ),
    );
    var helpAndSupport = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Help and support', style: AppConst.titleText1,),
              SizedBox(height: 10,),
              Text('Check our FAQ\'s and useful links', style: AppConst.descriptionText,),
            ],
          ),
        ],
      ),
    );
    var howToUse = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('How to use', style: AppConst.titleText1,),
              SizedBox(height: 10,),
              Text('Store rewards', style: AppConst.descriptionText,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Visit our youtube channel', style: TextStyle(fontSize: 8, color: AppConst.themePurple, fontFamily: 'Stag', letterSpacing: 0.3, decoration: TextDecoration.underline),),
              Container(
                height: 25,
                child: Image(image: AssetImage('assets/images/yt.png'),),
              ),
            ],
          ),
        ],
      ),
    );
    var fastOrders = Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Text('Fast Orders', style: AppConst.titleText1,),],),
        Divider(height: 40, color: Colors.grey[300], thickness: 1,),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Samsung home appliance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Stag', color: Color(0xff777C87))),
                  SizedBox(height: 10,),
                  Text('Cashback balance', style: AppConst.descriptionText,),
                ],
              ),
              Text('1,500 ₹', style: AppConst.titleText1Purple,),
            ],
          ),
        ),
        SizedBox(height: 15,),
        Row(children: [Text('Refrigerator x1, Air condition x1', style: TextStyle(fontSize: 10, color: Color(0xff777C87), fontFamily: 'Stag', letterSpacing: 0.3),),],),
        SizedBox(height: 15,),
        Row(
          children: [
            Flexible(
              child: Container(
                height: 30,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  gradient: AppConst.gradient1,
                  borderRadius: BorderRadius.circular(3)
                ),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3)
                    ),
                    child: Center(
                      child: Text('Go to store', style: AppConst.descriptionText,),
                    ),
                  ),
                ),
              )
            ),
            SizedBox(width: 20,),
            Flexible(
                child: Container(
                  height: 30,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      gradient: AppConst.gradient1,
                      borderRadius: BorderRadius.circular(3)
                  ),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)
                      ),
                      child: Center(
                        child: Text('Support', style: AppConst.descriptionText,),
                      ),
                    ),
                  ),
                )
            ),
          ],
        ),
        SizedBox(height: 20,),
        Container(
          // height: 28,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            // boxShadow: [AppConst.shadowBasic],
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: Colors.grey[300], width: 1)
          ),
          child: Center(
            child: Text('View all orders', style: AppConst.descriptionTextPurple,),
          ),
        )
      ],
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Account', style: TextStyle(fontFamily: 'Stag', color: Colors.white, fontSize: 14),),
          actions: [
            Row(
              children: [
                Icon(FeatherIcons.settings, color: Colors.white, size: 15,),
                SizedBox(width: 5,),
                Text('Settings', style: TextStyle(color: Colors.white, fontSize: 13),),
                SizedBox(width: 5,),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 20,),
                headerWidget,
                SizedBox(height: 20,),
                referBanner,
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      lifeTimeCashBack,
                      SizedBox(height:20,),
                      manageAddress,
                      SizedBox(height: 20,),
                      myRank,
                      SizedBox(height: 20,),
                      helpAndSupport,
                      SizedBox(height: 20,),
                      howToUse,
                      SizedBox(height: 20,),
                      fastOrders,

                    ],
                  ),
                ),
                SizedBox(height: 80,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
