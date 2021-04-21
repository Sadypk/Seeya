import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {
  final String image;
  CircleImageWidget({this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 54,
        width: 54,
        // margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage(image),
          ),
          // border: Border.all(color: Colors.grey[500]),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 5,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
      );
  }
}
