import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view_models/top_products_view_model.dart';
import 'package:seeya/features/scan_receipt/view_model/purchased_product_view_model.dart';
import 'package:seeya/features/store/models/cart_model.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget.dart';
import 'package:seeya/home.dart';
import 'package:seeya/main_app/util/size_config.dart';

class PurchasedProductsScreen extends StatefulWidget {
  final StoreModel storeModel;
  PurchasedProductsScreen({this.storeModel});
  @override
  _PurchasedProductsScreenState createState() => _PurchasedProductsScreenState();
}

class _PurchasedProductsScreenState extends State<PurchasedProductsScreen> {
  final GetSizeConfig getSizeConfig = Get.find();

  final Duration _duration = Duration(milliseconds: 400);

  List<File> images;

  PurchasedProductViewModel vm;
  @override
  void initState() {
    Get.put(PurchasedProductViewModel());
    vm = Get.find();
    Get.put(TopProductsViewModel());
    TopProductsViewModel topProductsViewModel = Get.find();
    topProductsViewModel.productList.forEach((v) { vm.purchasedList.add(CartModel(product: v, count: 0));});
    super.initState();
    images = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   iconTheme: IconThemeData(
      //     color: Colors.white
      //   ),
      //   backgroundColor: Colors.transparent,
      // ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: images.length,
            shrinkWrap: true,
            itemBuilder: (_, index) => Image.file(images[index]),
            // itemBuilder: (_, index) => AssetThumb(asset: assets[index],height: (Get.height * .7).toInt(), width: (Get.width).toInt()),
          ),
          if(widget.storeModel!=null) _buildBottomDrawer(),
          if(widget.storeModel==null)Positioned(
            top: Get.height-100,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              ),
              child: submitTextField,
            ),
          )
        ],
      )
    );
  }

  double initialGap = Get.height * .6;
  double expandedGap = AppBar().preferredSize.height + Get.mediaQuery.padding.top;
  bool bottomDrawerIsOpen = false;

  _buildBottomDrawer()=> AnimatedPositioned(
    duration: _duration,
    top: bottomDrawerIsOpen ? expandedGap : initialGap,
    bottom: 0,
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
        TextButton(
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
    PurchasedProductViewModel vm = Get.find();
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        itemCount: vm.purchasedList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index){
          var isSelected = false.obs;
          return new Obx((){
            return vm.purchasedList[index].product!=null?ProductCardWidget(
              productModel: vm.purchasedList[index].product,
              iconButton: IconButton(
                icon: Icon(!isSelected.value?Icons.add_circle_outline_rounded:FontAwesomeIcons.checkCircle, color: !isSelected.value?Colors.red:Colors.green, size: 22,),
                onPressed: (){
                  isSelected.value = true;
                  vm.purchasedList[index].count++;
                },
              ),
              quantityController: vm.purchasedList[index].count>0?Container(
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: (){
                          if(vm.purchasedList[index].count>1){
                            vm.purchasedList[index].count--;
                          }
                          // vm.cartItemsWithQuantity.add(CartModel(count: 0));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(3), bottomLeft: Radius.circular(3))
                          ),
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Icon(Icons.remove, color: Colors.white, size: 12,),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text(vm.purchasedList[index].count.toString(), style: TextStyle(color: Colors.white, fontSize: 12),),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: (){
                          vm.purchasedList[index].count++;
                          print(vm.purchasedList[index].count);
                          // vm.cartItemsWithQuantity.add(CartModel(count: 0));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(3), bottomRight: Radius.circular(3))
                          ),
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Icon(Icons.add, color: Colors.white, size: 12,),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ):SizedBox(),
            ):SizedBox();
          });
        },
      ),
    );
  }
}

class GridListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PurchasedProductViewModel vm = Get.find();
    return Expanded(
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 5),
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            /// number of child in a row
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            childAspectRatio: ((MediaQuery.of(context).size.width/2)/220),
          ),
          itemCount: vm.purchasedList.length,
          itemBuilder: (BuildContext context, int index){
            var isSelected = false.obs;
            return new Obx((){
              return vm.purchasedList[index].product!=null?ProductCardWidget(
                productModel: vm.purchasedList[index].product,
                iconButton: IconButton(
                  icon: Icon(!isSelected.value?Icons.add_circle_outline_rounded:FontAwesomeIcons.checkCircle, color: !isSelected.value?Colors.red:Colors.green, size: 22,),
                  onPressed: (){
                    isSelected.value = true;
                    vm.purchasedList[index].count++;
                  },
                ),
                quantityController: vm.purchasedList[index].count>0?Container(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: (){
                            if(vm.purchasedList[index].count>1){
                              vm.purchasedList[index].count--;
                              vm.purchasedList.add(CartModel(count: 0));
                            }
                            // vm.cartItemsWithQuantity.add(CartModel(count: 0));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(3), bottomLeft: Radius.circular(3))
                            ),
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Icon(Icons.remove, color: Colors.white, size: 12,),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Text(vm.purchasedList[index].count.toString(), style: TextStyle(color: Colors.white, fontSize: 12),),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: (){
                            vm.purchasedList[index].count++;
                            print(vm.purchasedList[index].count);
                            vm.purchasedList.add(CartModel(count: 0));
                            // vm.cartItemsWithQuantity.add(CartModel(count: 0));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(3), bottomRight: Radius.circular(3))
                            ),
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Icon(Icons.add, color: Colors.white, size: 12,),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ):SizedBox(),
              ):SizedBox();
            });
          },
        ),
      ),
    );
  }
}
