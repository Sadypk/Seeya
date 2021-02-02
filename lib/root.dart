import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seeya/features/authentication/view/phone_verification_screen.dart';
import 'package:seeya/features/home_screen/view/home_screen.dart';
import 'package:seeya/features/my_offers_screen/view/my_offers_screen.dart';
import 'package:seeya/features/profile_screen/view/profile_screen.dart';
import 'package:seeya/features/search_screen/view/search_screen.dart';
import 'package:seeya/home.dart';
import 'package:seeya/main_app/resources/string_resources.dart';
import 'package:get/get.dart';
import 'package:seeya/main_app/util/size_config.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  var isLoggedIn = true;
  GetSizeConfig getSizeConfig = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    initiateSize();
    Future.delayed(Duration(seconds: isLoggedIn?1:2)).then((value){
      isLoggedIn?
      Get.offAll(Home()):
      Get.to(PhoneVerificationScreen());
    });
    super.initState();
  }

  initiateSize() {
    getSizeConfig.setSize(Get.height / 1000, Get.width / 1000);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Logo', style: TextStyle(fontSize: 30),),
      ),
    );
  }
}

