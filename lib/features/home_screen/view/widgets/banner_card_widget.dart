import 'package:flutter/material.dart';
import 'package:seeya/features/home_screen/models/banner_model.dart';

class BannerCardWidget extends StatelessWidget {
  final BannerModel bannerModel;
  BannerCardWidget(this.bannerModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 200,
      margin: EdgeInsets.only(right: 10),
      child: Card(
        color: Colors.purpleAccent[100],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(bannerModel.title??'', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic),),
              SizedBox(height: 10,),
              Text(bannerModel.bannerDescription??'', style: TextStyle(fontSize: 13, height: 0.5),),
            ],
          ),
        ),
      ),
    );
  }
}
