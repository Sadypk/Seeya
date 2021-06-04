import 'package:flutter/material.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/custom_outline_button.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';

class SuccessPage extends StatefulWidget {
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff666666)),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.width-40,
                width: MediaQuery.of(context).size.width-40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/mobile_art.png'),
                    )
                ),
              )
            ],
          ),
          SizedBox(height: 25,),
          Text('Congratulations', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, fontFamily: 'Stag', color: AppConst.themePurple),),
          SizedBox(height: 12,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('₹', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Stag', color: AppConst.themePurple),),
              Text('150.00', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, fontFamily: 'Stag', color: AppConst.themePurple),),
            ],
          ),
          SizedBox(height: 12,),
          Text('You will be rewarded', style: AppConst.header2,),
          Text('in your account within 24 hours.', style: AppConst.header2,),
          SizedBox(height: 40,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CustomOutlineButton(
              height: 40,
              label: 'Redeem another receipt',
              fontStyle: AppConst.header,
            ),
          ),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: GradientButton(
              height: 40,
              label: 'Done',
              fontStyle: TextStyle(fontFamily: 'Stag', fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
