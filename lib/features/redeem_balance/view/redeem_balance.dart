import 'package:flutter/material.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/store/view/widgets/store_tile_widget.dart';
import 'package:seeya/main_app/resources/string_resources.dart';
import 'package:get/get.dart';

class RedeemBalanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var totalBalance = 0.obs;

    var submitBalanceControl = Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300], width: 1),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
                      BoxShadow(
                          color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
                    ],
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                        ),
                        hintText: StringResources.enterRedeemBalanceText,
                        hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text('   Total Balance: ${totalBalance.value}₹', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),)
              ],
            ),
          ),
          FlatButton(onPressed: (){}, child: Container(
            height: 45,
            width: 100,
            decoration: BoxDecoration(
              color: totalBalance.value!=0?Colors.blue:Colors.grey,
              borderRadius: BorderRadius.circular(3)
            ),
            child: Center(
              child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
            ),
          ))
        ],
      ),
    );



    var storeList = NearestStoreViewModel().storeList;
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.redeemBalanceAppbarTitleText),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            submitBalanceControl,
            Divider(height: 50,),
            Text(StringResources.storeRedeemSelectListText, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            SizedBox(height: 10,),
            Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index){
                    return StoreTileWidget(storeModel: storeList[index],);
                  },
                  itemCount: storeList.length,
                )
            )
          ],
        ),
      ),
    );
  }
}
