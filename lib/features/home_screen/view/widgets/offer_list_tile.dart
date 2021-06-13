import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/resources/string_resources.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';
import 'package:seeya/newMainAPIs.dart';

import '../all_offers_near_you.dart';

class OfferListTile extends StatefulWidget {
  final StoreData data;

  const OfferListTile({Key key, this.data}) : super(key: key);
  @override
  _OfferListTileState createState() => _OfferListTileState();
}

class _OfferListTileState extends State<OfferListTile> {
  bool isTaken = false;
  @override
  Widget build(BuildContext context) {
    num offer = widget.data.defaultWelcomeOffer;
    final today = DateTime.now();
    if(widget.data.promotionWelcomeOfferStatus == 'active'){
      if(widget.data.promotionWelcomeOfferDate.startDate.isBefore(today) &&  widget.data.promotionWelcomeOfferDate.endDate.isAfter(today)){
        offer = widget.data.promotionWelcomeOffer;
      }
    }
    return GestureDetector(
      onTap: (){
        final index = offersNearYouStores.indexOf(widget.data);
        if(widget.data.flag == 'true'){
          offersNearYouStores[index].flag = 'false';
        }else{
          offersNearYouStores[index].flag = 'true';
        }
        offersNearYouStores.refresh();
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 25),
            height: 70,
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey[200]),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0.5,
                      blurRadius: 0.5,
                      offset: Offset(0,0.5),
                      color: Colors.grey[300]
                  )
                ],
                color: Colors.white
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleImageWidget(image: widget.data.logo,),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.data.name, style: AppConst.header,),
                          SizedBox(height: 4,),
                          Text('10% cashback', style: AppConst.descriptionTextPurple,)
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${(widget.data.distance/1000).toStringAsFixed(1)} km', style: AppConst.descriptionText,),
                    SizedBox(height: 4,),
                    Text('Redeem $offer ${StringResources.rupee}', style: TextStyle(color: AppConst.themePurple, fontSize: 12, fontFamily: 'Stag'),)
                  ],
                )
              ],
            ),
          ),
          if(widget.data.flag != 'disabled')Positioned(
            bottom: 12,
            right: 10,
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.data.flag == 'true'?Color(0xff15B025):Colors.red
              ),
              child: Center(
                child: Icon(widget.data.flag == 'true' ? Icons.done_rounded:Icons.add, color: Colors.white, size: 16,)
              ),
            ),
          )
        ],
      ),
    );
  }
}
