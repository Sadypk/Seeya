
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/order_online/view/store_view.dart';
import 'package:seeya/features/scan_receipt/theBoss/view/cameraView.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/features/store/view/widgets/top_picks_card_widget.dart';
import 'package:seeya/main_app/resources/app_const.dart';

import '../../../newMainAPIs.dart';

class RecentVisits extends StatelessWidget {
  final List<StoreData> data;

  const RecentVisits({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .9
        ),
        itemCount: data.length,
        itemBuilder: (_, index) => GestureDetector(
          onTap: (){
           Get.to(() => StoreView(storeData: data[index]));
          },
          child: Column(
            children: [
              TopPicksCardWidget(storeModel: StoreModel(promotionCashback: 25, logo: data[index].logo), height: 90, width: 100, fontSize: 8,),
              SizedBox(height: 10,),
              Text(data[index].name, style: AppConst.header2 ,)
            ],
          ),
        )
    );
  }
}
