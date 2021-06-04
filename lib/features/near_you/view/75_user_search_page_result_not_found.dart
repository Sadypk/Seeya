import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:seeya/features/near_you/view/76_success_page.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';

class UserSearchPageResultNotFound extends StatefulWidget {
  @override
  _UserSearchPageResultNotFoundState createState() => _UserSearchPageResultNotFoundState();
}

class _UserSearchPageResultNotFoundState extends State<UserSearchPageResultNotFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff666666)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Color(0xff252525).withOpacity(0.4)),
                color: Colors.white
            ),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Icon(Icons.search, color: AppConst.black.withOpacity(0.7),)),
                Flexible(child: TextFormField(
                  // controller: searchController,
                  decoration: InputDecoration(
                      hintText: 'Search stores and products',
                      hintStyle: TextStyle(fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'open',
                          color: AppConst.black.withOpacity(0.7)),
                      suffixIcon: Icon(FeatherIcons.x)
                  ),
                ))
              ],
            ),
          ),
          SizedBox(height: 25,),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text('Trending near you', style: AppConst.header2,),
                  SizedBox(height: 10,),
                  Text('No history found', style: TextStyle(fontSize: 14, fontFamily: 'Stag', fontWeight: FontWeight.w400, color: Color(0xff777c87)),)
                ],
              )),
          SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: GradientButton(
              onTap: (){
                Get.to(SuccessPage());              },
              height: 40,
              label: 'Go to scan receipts',
              fontStyle: TextStyle(fontFamily: 'Stag', fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
