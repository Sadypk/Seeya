import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppConst{
  static const Color themePurple = Color(0xff9D239A);
  static const Color themeBlue = Color(0xff0067BD);
  static const Color blue = Color(0xff136EB4);
  static const Color black = Color(0xff000000);
  static final Duration duration = Duration(milliseconds: 300);


  //Linear Gradient
  static LinearGradient gradient1 = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xff4A3980), Color(0xff9D239A)]
  );

  //box shadow
  static BoxShadow shadowBasic = BoxShadow(
      color: Colors.grey[300],
      spreadRadius: 1,
      blurRadius: 1,
      offset: Offset(0.5,0.5)
  );
  static BoxShadow shadowBasic2 = BoxShadow(
      color: Colors.grey[300],
      spreadRadius: 1,
      blurRadius: 1,
      offset: Offset(-0.5,-0.5)
  );
  static BoxShadow shadowBottomNavBar = BoxShadow(
      color: Colors.grey[300],
      spreadRadius: 0.6,
      blurRadius: 0.6,
      offset: Offset(0,-1)
  );

  //Font Styles
  static TextStyle appbarTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3);

  static TextStyle titleText1 = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Stag');
  static TextStyle titleText1Purple = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Stag', color: themePurple);
  static TextStyle titleText1White = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Stag', color: Colors.white,letterSpacing: .5);


  static TextStyle titleText2 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'Stag');
  static TextStyle titleText2Purple = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'Stag', color: AppConst.themePurple);

  static TextStyle header = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Stag', letterSpacing: 0.3);
  static TextStyle header2 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3);
  static TextStyle header2Purple = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Stag', letterSpacing: 0.3);
  static TextStyle purpleTextBold = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: themePurple, fontFamily: 'Stag', letterSpacing: 0.3);

  static TextStyle descriptionText2 = TextStyle(fontSize: 14, color: black,fontWeight: FontWeight.w400, fontFamily: 'Stag', letterSpacing: 0.3);
  static TextStyle descriptionTextWhite2 = TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Stag', letterSpacing: 0.3);
  static TextStyle descriptionTextPurple2 = TextStyle(fontSize: 14, color: themePurple, fontFamily: 'Stag', letterSpacing: 0.3);

  static TextStyle descriptionText = TextStyle(fontSize: 10, color: black, fontFamily: 'Stag', letterSpacing: 0.3);
  static TextStyle descriptionTextPurple = TextStyle(fontSize: 8,fontWeight: FontWeight.w600, color: themePurple, fontFamily: 'open', letterSpacing: 0.3);
  static TextStyle descriptionTextRed = TextStyle(fontSize: 10, color: Color(0xffEE175B), fontFamily: 'Stag', letterSpacing: 0.3, fontWeight: FontWeight.w600);
  static TextStyle descriptionTextWhite = TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'open', letterSpacing: 0.3);

  //image paths
  static String referAndEarnImage = 'assets/images/Refer and earn illustration.png';

/*  static final Widget couponIcon = SvgPicture.asset(
    'assets/images/svg/coupon.svg',
    color: pink
  );*/
}
