
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/order_online/view/store_view.dart';
import 'package:seeya/features/scan_receipt/theBoss/view/cameraView.dart';

import '../../../newMainAPIs.dart';

class SpecialOffer extends StatelessWidget {
  final List<BoomModel> data;

  const SpecialOffer({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: (){
              Get.to(() => StoreView(data: data[index]));
            },
            child: Container(

                child: Column(
                  children: [
                    StoreShopNowTile2(label: 'Something', boomModel: data[index]),
                    Divider(height: 40,)
                  ],
                )),
          );
        });
  }
}