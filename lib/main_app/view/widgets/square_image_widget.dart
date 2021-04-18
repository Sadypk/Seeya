import 'package:flutter/material.dart';

class SquareImageWidget extends StatelessWidget {
  final String image;
  SquareImageWidget({this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: 60,
      // margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(image),
        ),
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

    );
  }
}
