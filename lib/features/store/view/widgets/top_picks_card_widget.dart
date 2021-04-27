import 'package:flutter/material.dart';
import 'package:seeya/features/store/models/storeModel.dart';

class TopPicksCardWidget extends StatelessWidget {
  final StoreModel storeModel;
  final double height;
  final double width;
  final double fontSize;
  TopPicksCardWidget({this.storeModel, this.width, this.height, this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      height: height??130,
      width: width??130,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: PhysicalModel(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
              elevation: 2,
              child: Container(
                height: height!=null?height-10:120,
                width: width??130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[100]),
                  image: DecorationImage(
                    image: NetworkImage(storeModel.logo),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
              left: 10,
              child: Container(
                width: width!=null?width-20:110,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.purpleAccent,
                ),
                child: Center(
                  child: Text('${storeModel.promotionCashback}% Cashbacks', style: TextStyle(color: Colors.white, fontSize: fontSize??11),),
                ),
              )
          )
        ],
      ),
    );
  }
}
