import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SquareImageWidget extends StatelessWidget {
  final String image;
  final String title;
  SquareImageWidget({this.image,this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
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
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: CachedNetworkImage(imageUrl: image)),
          SizedBox(height: 4),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Stag'
              ),
            ),
          )
        ],
      ),
    );
  }
}
