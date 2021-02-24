import 'package:flutter/material.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/store/view/widgets/store_tile_widget.dart';
import 'package:seeya/main_app/resources/string_resources.dart';
import 'package:get/get.dart';

class RedeemBalanceScreen extends StatefulWidget {
  @override
  _RedeemBalanceScreenState createState() => _RedeemBalanceScreenState();
}

class _RedeemBalanceScreenState extends State<RedeemBalanceScreen> {
  @override
  Widget build(BuildContext context) {
    var totalBalance = 0.obs;

    var submitBalanceControl = Obx((){
      return Container(
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
    });

    imageWidget(String img){
      return Container(
        height: 50,
        width: 50,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[500]),
          boxShadow: [
            BoxShadow(
                offset: Offset(1,1),
                color: Colors.grey,
                blurRadius: 1,
                spreadRadius: 1
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:
            Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: [
              Colors.black45,
              Colors.grey[200]
            ], // red to yellow
          ),
        ),
        child: Center(
          child: Container(
            height: 40,
            width: 40,
            // padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                    image: NetworkImage(img),
                    fit: BoxFit.cover
                )
            ),
          ),
        ),
      );
    }



    var storeList = NearestStoreViewModel().storeList;
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.redeemBalanceAppbarTitleText, style: TextStyle(color: Colors.black87),),
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
                    bool check = false;
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        elevation: check?5:3,
                        child: StatefulBuilder(
                          builder: (context, _setState){
                            return CheckboxListTile(
                              value: check,
                              activeColor: check?Colors.greenAccent[100]:Colors.white,
                              onChanged: (bool v){
                                  _setState((){check = v;
                                  if(v){
                                    totalBalance.value += 120;
                                  }else{totalBalance.value -= 120;}
                                });
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      imageWidget(storeList[index].logo),
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(storeList[index].name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                          // storeList[index].storeLocation!=null?Text(storeList[index].storeLocation, style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.blue),):SizedBox()
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('120\$', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                      // storeList[index].distance!=null?Text('${storeList[index].distance.round()}km away', style: TextStyle(fontSize: 12, color: Colors.green),):SizedBox(),
                                    ],
                                  )

                                ],
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                            );
                          },
                        ),
                      ),
                    );
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
