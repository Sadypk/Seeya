import 'dart:io';

import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/products_tile_widget.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget.dart';
import 'package:seeya/home.dart';
import 'package:seeya/main.dart';
import 'package:seeya/main_app/models/product_model.dart';
import 'package:seeya/main_app/util/size_config.dart';

class PurchasedProductsScreen extends StatefulWidget {
  // final XFile image;
  // PurchasedProductsScreen({this.image});
  @override
  _PurchasedProductsScreenState createState() => _PurchasedProductsScreenState();
}

class _PurchasedProductsScreenState extends State<PurchasedProductsScreen> {
  final GetSizeConfig getSizeConfig = Get.find();

  final BottomDrawerController _controller = BottomDrawerController();

  final Duration _duration = Duration(milliseconds: 400);

  File image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    double h(double x){return getSizeConfig.height*x;}
    double w(double x){return getSizeConfig.width*x;}


    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(height: Get.height, width: Get.width),
              Container(
                height: h(1550),
                color: Colors.orangeAccent,
                child: Image.file(image),
              ),
              _buildBottomDrawer(),
            ],
          ),
        )
      ),
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
            SizedBox(height: 5,),
            submitTextField,
            SizedBox(height: 5,),
          ],
        ),
      ),
    ),
  );
}

var amountController = TextEditingController().obs;
var canSubmit = false.obs;
var submitTextField = Obx((){
  return Container(
    padding: EdgeInsets.only(left: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
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
              controller: amountController.value,
              onChanged: (v){if(v.length>0) {
                canSubmit.value = true;
                }else{
                canSubmit.value = false;
                }
              },
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  hintText: 'Enter Bill Amount',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)
              ),
            ),
          ),
        ),
        FlatButton(
            onPressed: canSubmit.value?(){
              Get.offAll(Home());
            }:(){},
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                  color: canSubmit.value?Colors.blue:Colors.grey,
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

class HorizontalListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index){
          var isSelected = false.obs;
          return new Obx((){
            return ProductCardWidget(
              productModel: ProductModel(
                  productId: 31,
                  // productImage: 'https://recipefairy.com/wp-content/uploads/2020/07/kfc-chicken-500x375.jpg',
                  productImage: 'https://5.imimg.com/data5/BL/BJ/MY-13659451/poultry-live-chicken-500x500.jpg',
                  productName: 'Chicken Fry',
                  productPrice: 14.99,
                  cashBack: 2
              ),
              iconButton: IconButton(
                icon: Icon(!isSelected.value?Icons.add_circle_outline_rounded:FontAwesomeIcons.checkCircle, color: !isSelected.value?Colors.red:Colors.green, size: 22,),
                onPressed: (){isSelected.value = !isSelected.value;},
              ),
            );
          });
        },
      ),
    );
  }
}

class GridListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
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
          itemBuilder: (BuildContext context, int index){
            var isSelected = false.obs;
            return new Obx((){
              return ProductCardWidget(
                productModel: ProductModel(
                    productId: 31,
                    // productImage: 'https://recipefairy.com/wp-content/uploads/2020/07/kfc-chicken-500x375.jpg',
                    productImage: 'https://5.imimg.com/data5/BL/BJ/MY-13659451/poultry-live-chicken-500x500.jpg',
                    productName: 'Chicken Fry',
                    productPrice: 14.99,
                    cashBack: 2
                ),
                iconButton: IconButton(
                  icon: Icon(!isSelected.value?Icons.add_circle_outline_rounded:FontAwesomeIcons.checkCircle, color: !isSelected.value?Colors.red:Colors.green, size: 22,),
                  onPressed: (){isSelected.value = !isSelected.value;},
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
