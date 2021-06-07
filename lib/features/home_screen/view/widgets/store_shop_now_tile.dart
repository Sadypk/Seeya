import 'package:flutter/material.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/resources/string_resources.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';
import 'package:seeya/newMainAPIs.dart';

class StoreShopNowTile extends StatelessWidget {
  final String title;
  final String image;
  final String subtitle;
  StoreShopNowTile({this.title, this.image, this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleImageWidget(image: image ?? 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660',),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14, fontFamily: 'Stag', ),),
                SizedBox(height: 3,),
                Text(subtitle ?? '10% Cashback', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'OpenSans', color: Color(0xffEE1717)),)
              ],
            )
          ],
        ),
        Text('Shop now', style: TextStyle(color: AppConst.themePurple, fontSize: 12, fontFamily: 'Stag', fontWeight: FontWeight.w400, decoration: TextDecoration.underline),),
      ],
    );
  }
}

class StoreShopNowTile2 extends StatelessWidget {
  final String label;
  final BoomModel boomModel;
  StoreShopNowTile2({this.label, this.boomModel});
  @override
  Widget build(BuildContext context) {

    num cashBack = 200;
    final today = DateTime.now();
    if(boomModel != null){
      cashBack = boomModel.defaultCashbackOffer;
      if(boomModel.promotionCashbackOfferStatus == 'active' && boomModel.promotionCashbackOfferDate.startDate.isBefore(today) && boomModel.promotionCashbackOfferDate.endDate.isAfter(today)){
        cashBack = boomModel.promotionCashbackOffer;
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleImageWidget(image: boomModel == null ? 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660' : boomModel.logo,),
            SizedBox(width: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(boomModel == null ? label : boomModel.name, style: TextStyle(fontSize: 14, fontFamily: 'Stag', ),),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text('10% Cashback', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, fontFamily: 'OpenSans', color: Color(0xffEE1717)),),
                ),
                Container(
                  width: 70,
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.purpleAccent,
                  ),
                  child: Center(
                    child: Text(boomModel == null ? label : '${boomModel.store_type} order', style: TextStyle(color: Colors.white, fontSize: 10),),
                  ),
                )
                  ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('$cashBack ${StringResources.rupee}', style: AppConst.titleText2Purple,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text('You earned 35.00', style: TextStyle(fontSize: 10, color: Color(0xff252525), fontFamily: 'Stag', letterSpacing: 0.3, fontWeight: FontWeight.w600)),
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined,color: Colors.purpleAccent,size: 15,),
                Text(boomModel == null ? label : '${(boomModel.calculated_distance/1000).toStringAsFixed(2)} km', style: TextStyle(fontSize: 10, color: Color(0xff252525), fontFamily: 'Stag', letterSpacing: 0.3, fontWeight: FontWeight.w600)),
              ],
            )
          ],
        )
      ],
    );
  }
}

class StoreShopNowTile3 extends StatelessWidget {
  final String label;
  StoreShopNowTile3({this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleImageWidget(image: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660',),
            SizedBox(width: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 14, fontFamily: 'Stag', ),),
                Text('10% Cashback', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, fontFamily: 'OpenSans', color: Color(0xffEE1717)),)
              ],
            )
          ],
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppConst.themePurple
          ),
          child: Center(
            child: Icon(Icons.message_rounded, color: Colors.white, size: 16,),
          ),
        )
      ],
    );
  }
}
