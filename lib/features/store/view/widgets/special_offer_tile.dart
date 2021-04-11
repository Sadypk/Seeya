import 'package:flutter/material.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';

class SpecialOfferTile extends StatelessWidget {
  final StoreModel storeModel;
  SpecialOfferTile({this.storeModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0,1),
            color: Colors.grey[200],
            blurRadius: 0.5,
            spreadRadius: 0.5
          ),
        ],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey[200]),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5, ),
            child: Text('Expires in: 1 day', style: AppConst.descriptionTextRed,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(storeModel.logo), fit: BoxFit.cover)
                ),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Limited time offer', style: AppConst.titleText1,),
                  SizedBox(height: 4,),
                  Text('Promotional clearing sale offer', style: AppConst.descriptionText,),
                  SizedBox(height: 2,),
                  Text('but 1 get 3 free', style: AppConst.descriptionText,),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
