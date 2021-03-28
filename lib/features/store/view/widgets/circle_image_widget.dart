import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {
  final String image;
  CircleImageWidget({this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        width: 70,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[500]),
          boxShadow: [
            BoxShadow(
                offset: Offset(1,1),
                color: Colors.grey[500],
                blurRadius: 1,
                spreadRadius: 1
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:
            Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: [
              Colors.black45,
              Colors.grey[200]
            ], // red to yellow
          ),
        ),
        child: Center(
          child: Container(
            height: 65,
            width: 65,
            // padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover
                // fit: BoxFit.cover
              ),
            ),

          ),
        ),
      );;
  }
}
