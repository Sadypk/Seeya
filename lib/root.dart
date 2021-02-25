import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:seeya/features/authentication/repository/authRepo.dart';
import 'package:seeya/features/authentication/view/phone_verification_screen.dart';
import 'package:seeya/home.dart';
import 'package:get/get.dart';
import 'package:seeya/main_app/util/size_config.dart';
import 'package:seeya/features/authentication/view/phone_verification_screen.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin{
  AnimationController animationController;

  bool error;
  @override
  void initState() {
    if(!mounted){
      return;
    }else{
      super.initState();
      checkSession();
      animationController = AnimationController(vsync: this);
    }
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  checkSession() async{
    print('Checking session...');
    if(GetStorage().hasData('userInfo')){
      print('Session Available');
      try{
        var data = GetStorage().read('userInfo');
        error = await AuthRepo.requestLogin(data['mobile']);
        if(error){
          Get.to(()=>SignInScreen());
        }else{
          Get.offAll(()=>Home());
        }
      }catch(e){
        print(e.toString());
        error = true;
      }
    }else{
      error = true;
      print('Session Unavailable');
    }
  }
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    sizeConfig.setSize((Get.height - (Get.mediaQuery.padding.top + Get.mediaQuery.padding.bottom)) / 1000, (Get.width - (Get.mediaQuery.padding.left + Get.mediaQuery.padding.right)) / 1000);
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lottie/splash.json',
        )
      ),
    );
  }
}

