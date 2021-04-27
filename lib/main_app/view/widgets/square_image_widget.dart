import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seeya/main_app/resources/app_const.dart';

class SquareImageWidget extends StatelessWidget {
  final String image;
  final String title;
  SquareImageWidget({this.image,this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 65,
      // margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        // border: Border.all(color: Colors.grey[500]),
        boxShadow: [
          BoxShadow(
              offset: Offset(0.3, 1),
              color: Colors.grey[300],
              blurRadius: 5,
              spreadRadius: 2
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.home,
            color: AppConst.themePurple,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Stag'
            ),
          )
        ],
      ),
    );
  }
}
