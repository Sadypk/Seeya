import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/all_offers_near_you.dart';
import 'package:seeya/main_app/resources/app_const.dart';

class OfferCardsGradient extends StatelessWidget {
  final String title;
  final String description;
  final Color begin;
  final Color end;
  OfferCardsGradient({this.description, this.title, this.end, this.begin});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(AllOffersNearYou());
      },
      child: Container(
        padding: EdgeInsets.only(left: 8),
        margin: EdgeInsets.only(right: 5),
        height: 90,
        width: 100,
        decoration: BoxDecoration(
          boxShadow: [],
          borderRadius: BorderRadius.circular(4),
          gradient: LinearGradient(
            colors: [begin, end],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppConst.titleText1White, ),
            SizedBox(height: 4,),
            Text(description, style: AppConst.descriptionTextWhite,),
            SizedBox(height: 10,),
            Text('View more', style: TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'Stag', letterSpacing: 0.3, decoration: TextDecoration.underline)),

          ],
        ),
      ),
    );
  }
}
