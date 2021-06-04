import 'package:flutter/material.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';

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
  StoreShopNowTile2({this.label});
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('200', style: AppConst.titleText2Purple,),
            Text('You earned 35.00', style: TextStyle(fontSize: 8, color: Color(0xff252525), fontFamily: 'Stag', letterSpacing: 0.3, fontWeight: FontWeight.w600))
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
