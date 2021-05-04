import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:seeya/main_app/resources/app_const.dart';

class ManageAddressScreen extends StatefulWidget {
  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  @override
  Widget build(BuildContext context) {
    var locationTiles = Container(
      height: 122,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xff707070), width: 0.5),
          borderRadius: BorderRadius.circular(4)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(FeatherIcons.mapPin, color: AppConst.themePurple, size: 16,),
          SizedBox(width: 5,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Work', style: AppConst.titleText1_2,),
                SizedBox(height: 3,),
                Text('Flat 108, 2nd Floor, Sunrise aurora apartment, Sanvi sankalpam main road, Bengaluru, Karnataka 560057, India.',
                  style: AppConst.descriptionTextOpen,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Edit', style: TextStyle(fontFamily: 'Stag', fontSize: 12, decoration: TextDecoration.underline, color: AppConst.themePurple),),
                    SizedBox(width: 30,),
                    Text('Delete', style: TextStyle(fontFamily: 'Stag', fontSize: 12, decoration: TextDecoration.underline, color: AppConst.themePurple),)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage address',style: AppConst.appbarTextStyle,),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            Padding(padding: EdgeInsets.only(left: 20),child: Text('Saved address', style: AppConst.titleText1,)),
            SizedBox(height: 10,),
            Expanded(child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index){
              return locationTiles;
            }))
          ],
        ),
      ),
    );
  }
}

