import 'package:flutter/material.dart';

class NearestStoreTileWidget extends StatelessWidget {
  var imageWidget = Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey[500]),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end:
        Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
        colors: [
          Colors.black45,
          Colors.black26
        ], // red to yellow
      ),
    ),
    child: Center(
      child: Container(
        height: 50,
        width: 50,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/dummy_image_1.jpg'),
            // fit: BoxFit.cover
          ),
        ),

      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[100])
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageWidget,
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Store Name', style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 3,),
              Text('Some Description Text', style: TextStyle(fontSize: 10),),
            ],
          )
        ],
      ),
    );
  }
}
