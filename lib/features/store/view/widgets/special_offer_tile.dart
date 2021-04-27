import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seeya/main_app/resources/app_const.dart';

class SpecialOfferTile extends StatelessWidget {
  final SpecialOfferTileData data;
  SpecialOfferTile({this.data});
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
            child: Text(data.label, style: AppConst.descriptionTextRed,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  image: DecorationImage(image: CachedNetworkImageProvider(data.image), fit: BoxFit.cover)
                ),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.title, style: AppConst.titleText1,),
                  SizedBox(height: 4,),
                  Text(data.subtitle1, style: AppConst.descriptionText,),
                  SizedBox(height: 2,),
                  Text(data.subtitle2, style: AppConst.descriptionText,),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class SpecialOfferTileData{
  String image;
  String title;
  String subtitle1;
  String subtitle2;
  String label;
  SpecialOfferTileData({
    @required this.title,
    @required this.image,
    @required this.subtitle1,
    @required this.subtitle2,
    @required this.label,
});

  static SpecialOfferTileData convertData(data){
    String image = data['logo'];
    String title;
    String subTitle1;
    String subTitle2;
    String label;
    final date = new DateTime.now();

    if(data['__typename'] == 'ProductData'){
      title = data['name'];
      subTitle1 = 'Cash back amount with selling price';
      subTitle2 = 'From ${data['store']['name']}';
      label = 'Expires in: ${DateTime.fromMillisecondsSinceEpoch(int.parse(data['expiry_date'])).difference(date).inDays} day';
    }else{
      num cashBack = 0;
      if(data['promotion_cashback_status'] == 'active'){
        if(date.isAfter(DateTime.fromMillisecondsSinceEpoch(int.parse(data['promotion_cashback_date']['start_date']))) && date.isBefore(DateTime.fromMillisecondsSinceEpoch(int.parse(data['promotion_cashback_date']['end_date'])))){
          cashBack = data['promotion_cashback'];
          label = 'Expires in: ${DateTime.fromMillisecondsSinceEpoch(int.parse(data['promotion_cashback_date']['end_date'])).difference(date).inDays} day';
        }else{
          cashBack = data['default_cashback'];
          label = '';
        }
      }else{
        cashBack = data['default_cashback'];
        label = '';
      }

      title = '$cashBack % cash back on purchase';
      subTitle1 = 'Was ${data['default_cashback']}';
      subTitle2 = 'From ${data['name']}';
    }



    return SpecialOfferTileData(title: title, image: image, subtitle1: subTitle1, subtitle2: subTitle2, label: label);
  }
}
