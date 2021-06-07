import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seeya/features/order_online/view/my_fav.dart';
import 'package:seeya/features/order_online/view/near_me.dart';
import 'package:seeya/main_app/resources/app_const.dart';

class OrderOnline extends StatefulWidget {
  @override
  _OrderOnlineState createState() => _OrderOnlineState();
}

class _OrderOnlineState extends State<OrderOnline> with SingleTickerProviderStateMixin{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Order Online', style: AppConst.appbarTextStyle,),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Icon(CupertinoIcons.search, color: Colors.white),
          SizedBox(width: 20,)
        ],
      ),
      body:  DefaultTabController(
        length: 2,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                  labelColor: Colors.black,
                  indicatorColor: AppConst.themePurple,
                  labelStyle: AppConst.header2,
                  unselectedLabelStyle: AppConst.header2,
                  tabs: [
                    Tab(text: 'My favourite',),
                    Tab(text: 'Near me',),
                  ]),
              SizedBox(height: 15,),
              Expanded(
                child: TabBarView(
                  children: [
                    MyFav(),
                    NearMe(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

