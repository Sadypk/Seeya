import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/store/view/store_screen.dart';
import 'package:seeya/main_app/models/store_model.dart';

class StoreTileWidget extends StatelessWidget {
  final StoreModel storeModel;
  StoreTileWidget({this.storeModel});


  @override
  Widget build(BuildContext context) {
    var imageWidget = Container(
      height: 70,
      width: 70,
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
          height: 55,
          width: 55,
          // padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(storeModel.storeImage, fit: BoxFit.cover,),
          ),
        ),
      ),
    );
    return InkWell(
      onTap: (){
        Get.to(StoreScreen(storeModel: storeModel,));
      },
      child: Container(
        height: 90,
        // padding: EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(15),
        //   border: Border.all(color: Colors.grey[100])
        // ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imageWidget,
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(storeModel.storeName??'', style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 3,),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 12,),
                        ),
                        RichText(
                          text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: storeModel.cashBackList[0].toString()+' Cash Back   ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                TextSpan(text: 'was '+storeModel.cashBackList[1].toString()+'%', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                              ]
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
