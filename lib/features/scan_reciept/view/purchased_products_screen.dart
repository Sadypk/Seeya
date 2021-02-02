import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/main_app/util/size_config.dart';

class PurchasedProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(GetSizeConfig());
    GetSizeConfig getSizeConfig = Get.find();
    double h(double x){return getSizeConfig.height*x;}
    double w(double x){return getSizeConfig.width*x;}

    double _headerHeight = h(500);
    double _bodyHeight = h(1500);
    BottomDrawerController _controller = BottomDrawerController();

    Widget _buildBottomDrawerHead(BuildContext context){
      return Container(
        height: _headerHeight,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
      );
    }

    Widget _buildBottomDrawerBody(BuildContext context){
      return Container(
        height: _bodyHeight,
        decoration: BoxDecoration(
            color: Colors.blue
        ),
      );
    }

    Widget _buildBottomDrawer(BuildContext context) {
      return BottomDrawer(
        header: _buildBottomDrawerHead(context),
        body: _buildBottomDrawerBody(context),
        headerHeight: _headerHeight,
        drawerHeight: _bodyHeight,
        color: Colors.lightBlueAccent,
        controller: _controller,
        cornerRadius: 50,
      );
    }


    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  height: h(1500),
                  color: Colors.orangeAccent,
                  child: Image.network('https://mcdonalds.com.au/sites/mcdonalds.com.au/files/Product-Details-BigMac-mobile-201904.jpg', fit: BoxFit.cover,),
                ),
              ]
            ),
          ),
          _buildBottomDrawer(context)
        ],
      ),
    );
  }
}
