import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';

class OfferListTile extends StatefulWidget {
  @override
  _OfferListTileState createState() => _OfferListTileState();
}

class _OfferListTileState extends State<OfferListTile> {
  bool isTaken = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    CircleImageWidget(image: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660',),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pizza Delivery Store', style: AppConst.header,),
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
                  Text('0.7 km', style: AppConst.descriptionText,),
                  SizedBox(height: 4,),
                  Text('10% cashback', style: TextStyle(color: AppConst.themePurple, fontSize: 12, fontFamily: 'Stag'),)
                ],
              )
            ],
          ),
        ),
        Positioned(
          bottom: 12,
          right: 10,
          child: InkWell(
            onTap: (){
              setState(() {
                isTaken = !isTaken;
              });
            },
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isTaken?Color(0xff15B025):Colors.red
              ),
              child: Center(
                child: Icon(isTaken?Icons.done_rounded:Icons.add, color: Colors.white, size: 16,)
              ),
            ),
          ),
        )
      ],
    );
  }
}
