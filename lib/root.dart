import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:seeya/features/authentication/repository/authRepo.dart';
import 'package:seeya/features/authentication/view/phone_verification_screen.dart';
import 'package:get/get.dart';
import 'package:seeya/features/settings/view/21_manage_address.dart';
import 'package:seeya/home.dart';
// import 'package:seeya/features/scan_receipt/camera_awesome_files/camerawesome_plugin.dart';
import 'package:seeya/main_app/util/size_config.dart';
import 'package:seeya/features/authentication/view/location_picker_screen.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';



class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin{

  bool error;
  @override
  void initState() {
    if(!mounted){
      return;
    }else{
      super.initState();
      checkSession();
    }
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
          if(UserViewModel.user.value.addresses.length > 0){
            bool hasActiveAddress = false;
            int index = 0;
            LatLng latLng;
            UserViewModel.user.value.addresses.forEach((element) {
              if(!hasActiveAddress){
                index = UserViewModel.user.value.addresses.indexOf(element);
                latLng = LatLng(element.location.lat, element.location.lng);
                hasActiveAddress = element.status;
              }
            });
            if(hasActiveAddress){
              UserViewModel.setLocationIndex(index);
              UserViewModel.setLocation(latLng, UserViewModel.user.value.addresses[index].id);
              Get.offAll(()=>Home());
            }else{
              Get.offAll(()=>ManageAddressScreen());
            }
          }else{
            Get.offAll(()=>LocationPickerScreen());
          }
        }
      }catch(e){
        print(e.toString());
        error = true;
        Future.delayed(Duration(seconds: 2),()=>Get.to(()=>SignInScreen()));
      }
    }else{
      error = true;
      print('Session Unavailable');
      Future.delayed(Duration(seconds: 2),()=>Get.to(()=>SignInScreen()));
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

