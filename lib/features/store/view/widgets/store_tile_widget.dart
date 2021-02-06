import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/store/view/store_screen.dart';
import 'package:seeya/features/store/models/store_model.dart';

class StoreTileWidget extends StatelessWidget {
  final StoreModel storeModel;
  final bool isClaimable;
  final Function onTap;
  StoreTileWidget({this.storeModel, this.isClaimable = false, this.onTap});


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
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(storeModel.storeImage),
              fit: BoxFit.cover
            )
          ),
        ),
      ),
    );

    var claimButton = Container(
      height: 30,
      width: 80,
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.white30),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300],
                offset: Offset(1,1),
                blurRadius: 1,
                spreadRadius: 1
            )
          ]
      ),
      child: Center(
        child: Text('Claim', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blueGrey),),
      ),
    );


    var cashBackText = storeModel.cashBackList.length>0?Row(
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
                if(storeModel.cashBackList.length>1)TextSpan(text: 'was '+storeModel.cashBackList[1].toString()+'%', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
              ]
          ),
        )
      ],
    ):SizedBox();


    return InkWell(
      onTap: onTap,
      child: Container(
        height: 110,
        // padding: EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(15),
        //   border: Border.all(color: Colors.grey[100])
        // ),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
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
                        if(storeModel.storeLocation!=null)Text(storeModel.storeLocation, style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.blue),),
                        if(storeModel.storeLocation!=null)SizedBox(height: 5,),
                        cashBackText
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(isClaimable)claimButton,
                    if(isClaimable)SizedBox(height: 15,),
                    if(storeModel.distance!=null)Text('${storeModel.distance.round()}km away', style: TextStyle(fontSize: 12, color: Colors.green),)
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
