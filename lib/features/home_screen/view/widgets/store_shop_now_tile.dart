import 'package:flutter/material.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/circle_image_widget.dart';

class StoreShopNowTile extends StatelessWidget {
  final String label;
  StoreShopNowTile({this.label});
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
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 14, fontFamily: 'Stag', ),),
                SizedBox(height: 3,),
                Text('10% Cashback', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'OpenSans', color: Color(0xffEE1717)),)
              ],
            )
          ],
        ),
        Text('Shop now', style: TextStyle(color: AppConst.themePurple, fontSize: 12, fontFamily: 'Stag', fontWeight: FontWeight.w400, decoration: TextDecoration.underline),)
      ],
    );
  }
}
