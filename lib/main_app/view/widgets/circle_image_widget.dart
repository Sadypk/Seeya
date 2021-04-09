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
