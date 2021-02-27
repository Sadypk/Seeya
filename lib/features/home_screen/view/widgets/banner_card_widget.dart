import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/models/banner_model.dart';

class BannerCardWidget extends StatelessWidget {
  final BannerModel bannerModel;
  BannerCardWidget(this.bannerModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: Get.width * .8,
      margin: EdgeInsets.only(right: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                bannerModel.bannerBackgroundImage
              ),
              fit: BoxFit.cover
            )
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          // child: Column(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(bannerModel.title??'', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic),),
          //     SizedBox(height: 10,),
          //     Text(bannerModel.bannerDescription??'', style: TextStyle(fontSize: 13, height: 0.5),),
          //   ],
          // ),
        ),
      ),
    );
  }
}
