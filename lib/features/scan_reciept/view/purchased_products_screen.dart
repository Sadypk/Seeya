import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/main.dart';
import 'package:seeya/main_app/util/size_config.dart';

class PurchasedProductsScreen extends StatefulWidget {
  @override
  _PurchasedProductsScreenState createState() => _PurchasedProductsScreenState();
}

class _PurchasedProductsScreenState extends State<PurchasedProductsScreen> {
  final GetSizeConfig getSizeConfig = Get.find();

  final BottomDrawerController _controller = BottomDrawerController();

  final Duration _duration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {

    double h(double x){return getSizeConfig.height*x;}
    double w(double x){return getSizeConfig.width*x;}

    /*double _headerHeight = h(550);
    double _bodyHeight = h(1700);


    Widget _buildBottomDrawerHead(BuildContext context){
      return Container(
        height: _headerHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Purchased products',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      bottomDrawerIsOpen = !bottomDrawerIsOpen;
                      if(bottomDrawerIsOpen){
                        _controller.close();
                      }else{
                        _controller.open();
                      }
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                        decoration: TextDecoration.underline
                      ),
                    ),
                  )
                ],
              ),
              Spacer()
            ],
          ),
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
    }*/

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SizedBox(height: Get.height, width: Get.width),
          Container(
            height: h(1550),
            color: Colors.orangeAccent,
            child: Image.network('https://mcdonalds.com.au/sites/mcdonalds.com.au/files/Product-Details-BigMac-mobile-201904.jpg', fit: BoxFit.cover,),
          ),
          _buildBottomDrawer(),
        ],
      )
    );
  }

  double initialGap = Get.height * .65;
  double expandedGap = AppBar().preferredSize.height + Get.mediaQuery.padding.top;
  bool bottomDrawerIsOpen = false;

  _buildBottomDrawer()=> AnimatedPositioned(
    duration: _duration,
    top: bottomDrawerIsOpen ? expandedGap : initialGap,
    left: 0,
    right: 0,
    child: GestureDetector(
      onTap: (){
        setState(() {
          bottomDrawerIsOpen = !bottomDrawerIsOpen;
        });
      },
      child: AnimatedContainer(
        duration: _duration,
        height: bottomDrawerIsOpen ? Get.height * .9 : Get.height * .35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Purchased products',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      setState(() {
                        bottomDrawerIsOpen = !bottomDrawerIsOpen;
                      });
                    },
                    child: Text(
                      bottomDrawerIsOpen ? 'Collapse' : 'See all',
                      style: TextStyle(
                          decoration: TextDecoration.underline
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottomDrawerIsOpen ? GridListWidget() : HorizontalListWidget(),
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.pinkAccent,
            )
          ],
        ),
      ),
    ),
  );
}

class HorizontalListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => ItemWidget(),
      ),
    );
  }
}

class GridListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          /// number of child in a row
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10
        ),
        itemCount: 20,
        itemBuilder: (_, index) => ItemWidget(),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 100,
        color: Colors.red,
      ),
    );
  }
}
