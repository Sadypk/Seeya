import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get_storage/get_storage.dart';
import 'package:seeya/features/authentication/repository/authRepo.dart';
import 'package:seeya/features/authentication/view/location_picker_screen.dart';
import 'package:seeya/main_app/util/customButton.dart';
import 'package:seeya/main_app/util/size_config.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/util/screenLoader.dart';
import 'package:seeya/main_app/util/snack.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  final GetSizeConfig getSizeConfig = Get.find();
  int store = 1;
  double width;
  double height;

  bool rememberMe = true;
  bool delay = true;

  String countryCode = '+880';
  TextEditingController mobile;

  FocusNode mobileNode = FocusNode();

  AnimationController _controller;

  Duration _duration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    } else {
      if(GetStorage().hasData('backup')){
        mobile = TextEditingController(text: GetStorage().read('backup')['mobile']);
        // mobile = TextEditingController(text: '99999999999');
      }else{
        mobile = TextEditingController();
      }
      setInitialScreenSize();
      startAnimation();
      listener();
    }
  }

  void dispose() {
    super.dispose();
    _controller?.dispose();

    mobile?.dispose();
    mobileNode?.dispose();
  }

  setInitialScreenSize() {
    getSizeConfig.setSize(
      (Get.width -
          (Get.mediaQuery.padding.left + Get.mediaQuery.padding.right)) /
          1000,
      (Get.height -
          (Get.mediaQuery.padding.top + Get.mediaQuery.padding.bottom)) /
          1000,
    );
    width = getSizeConfig.width.value;
    height = getSizeConfig.height.value;
  }

  startAnimation() async {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _controller.forward();
  }

  listener() {
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {

        if(mounted){
          setState(() {
            delay = false;
          });
        }

      }
    });
  }

  bool loading = false;
  screenLoading()=> setState(() => loading = !loading);
  @override
  Widget build(BuildContext context) {
    return IsScreenLoading(
      screenLoading: loading,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white, //_animationColor.value,
          body: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 70),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          upperTitle(),
                          AnimatedCrossFade(
                            firstChild: SizedBox(),
                            secondChild: form(),
                            crossFadeState: delay
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: _duration,
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  upperTitle() {
    return Container(
      height: getSizeConfig.width * 150,
      width: getSizeConfig.width * 850,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "StoreBill ",
            style: TextStyle(
                fontSize: 32,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          RotateAnimatedTextKit(
              duration: Duration(seconds: 3),
              repeatForever: true,
              text: ["Custmoer"],
              textStyle: TextStyle(
                  fontSize: 32,
                  color: AppConst.themeBlue,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start
          ),
        ],
      ),
    );
  }

  Padding form() {
    return Padding(
      padding: EdgeInsets.only(top: height * 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          mobileTextField(),
          //passwordTextField(),
          //rememberMeCheckbox(),
          showButton ? signInButton() : SizedBox()
        ],
      ),
    );
  }

  bool showButton = false;

  Padding mobileTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 10),
      child: TextField(
        onChanged: (value){
          if(mobile.text.length >=10){
            setState(() {
              showButton = true;
            });
          }else{
            setState(() {
              showButton = false;
            });
          }
        },
        controller: mobile,
        keyboardType: TextInputType.number,
        focusNode: mobileNode,
        inputFormatters: [LengthLimitingTextInputFormatter(11)],
        decoration: InputDecoration(
          prefixText: countryCode,
          prefixStyle: TextStyle(color: Colors.black, fontSize: 16),
          contentPadding: EdgeInsets.symmetric(
              vertical: height * 5, horizontal: width * 30),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * 20),
              borderSide: BorderSide(
                color: AppConst.black,
              )
          ),
          labelText: 'Enter your mobile number',
        ),
      ),
    );
  }


  /// make the button come up when there is a phone number
  Padding signInButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 30),
      child: CustomButton(
        radius: width * 30,
        color: AppConst.themeBlue,
        title: 'Sign Up',
        function: () async{
          FocusScope.of(context).unfocus();
          if(mobile.text.length < 6){
            Snack.bottom('Error', 'Enter User name');
          }else{
            screenLoading();
            bool error = await AuthRepo.requestLogin(mobile.text);
            print(error);
            screenLoading();
            if(error){

            }else{
              GetStorage().write('userInfo', {'mobile' : mobile.text});
              GetStorage().write('backup', {'user' : mobile.text});
              if(UserViewModel.user.value.addresses.length > 0){
                Get.offAll(()=>AddressListScreen());
              }else{
                Get.offAll(()=>LocationPickerScreen());
              }
            }
          }
        },
      ),
    );
  }
}