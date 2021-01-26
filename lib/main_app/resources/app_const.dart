import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppConst{
  static const Color themeBlue = Color(0xff0067BD);
  static const Color blue = Color(0xff136EB4);
  static const Color black = Color(0xff000000);
  static final Duration duration = Duration(milliseconds: 300);

  static final BoxShadow shadow = BoxShadow(
      color: Colors.grey,
      spreadRadius: 5,
      blurRadius: 15
  );

/*  static final Widget couponIcon = SvgPicture.asset(
    'assets/images/svg/coupon.svg',
    color: pink
  );*/
}
