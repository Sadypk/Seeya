import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view_models/top_products_view_model.dart';
import 'package:seeya/features/scan_receipt/view_model/purchased_product_view_model.dart';
import 'package:seeya/features/store/models/cart_model.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget.dart';
import 'package:seeya/home.dart';
import 'package:seeya/main_app/models/productModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/util/screenLoader.dart';
import 'package:seeya/main_app/util/size_config.dart';
import 'package:seeya/main_app/util/snack.dart';
import 'package:seeya/newMainAPIs.dart';

class PurchasedProductsScreen extends StatefulWidget {
  static RxList<ProductModel> products = <ProductModel>[].obs;
  static RxList<RawProduct> rawItem = <RawProduct>[].obs;


  final BoomModel storeModel;
  PurchasedProductsScreen({this.storeModel});
  @override
  _PurchasedProductsScreenState createState() => _PurchasedProductsScreenState();
}
var canSubmit = false.obs;

class _PurchasedProductsScreenState extends State<PurchasedProductsScreen> {
  final GetSizeConfig getSizeConfig = Get.find();

  final Duration _duration = Duration(milliseconds: 400);

  List<File> images;
  final amountController = TextEditingController();

  PurchasedProductViewModel vm;
  @override
  void initState() {
    PurchasedProductsScreen.products.clear();
    Get.put(PurchasedProductViewModel());
    vm = Get.find();
    Get.put(TopProductsViewModel());
    TopProductsViewModel topProductsViewModel = Get.find();
    topProductsViewModel.productList.forEach((v) { vm.purchasedList.add(CartModel(product: v, count: 0));});
    super.initState();
    images = Get.arguments;
  }



  bool screenLoading = false;
  loadScreen() => setState(() => screenLoading = !screenLoading);

  @override
  Widget build(BuildContext context) {
    return IsScreenLoading(
      screenLoading: screenLoading,
      child: Scaffold(
        backgroundColor: Colors.black,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          backgroundColor: AppConst.themePurple,
          title: Text(
            'Add your bill',
            style: TextStyle(
              fontFamily: 'Stag',
              fontSize: 16
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: 100,
          shrinkWrap: true,
          itemBuilder: (_, index) => Image.file(images[0]),
          // itemBuilder: (_, index) => AssetThumb(asset: assets[index],height: (Get.height * .7).toInt(), width: (Get.width).toInt()),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: widget.storeModel!=null  ? _buildBottomDrawer() : SizedBox(),
      ),
    );
  }

  double initialGap = Get.height * .6;
  double expandedGap = AppBar().preferredSize.height + Get.mediaQuery.padding.top;
  bool bottomDrawerIsOpen = false;

  _buildBottomDrawer()=> Padding(
    padding: EdgeInsets.all(bottomDrawerIsOpen ? 0 : 20),
    child: AnimatedContainer(
      duration: _duration,
      height: bottomDrawerIsOpen ? Get.height * .8 : Get.height * .11,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bottomDrawerIsOpen ? GridListWidget(storeID: widget.storeModel.id) : SizedBox(height: 8,),
          if(bottomDrawerIsOpen)SizedBox(height: 8,),
          Obx((){
            print(canSubmit);
            return Container(
              height: 35,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey[300], width: 1),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff000000).withOpacity(0.2), blurRadius: 1),
                  BoxShadow(
                      color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 1),
                ],
              ),
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    suffix: InkWell(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        if(amountController.text.isNotEmpty){
                          loadScreen();
                          bool error = await NewApi.placeOrder(
                            images: images,
                            total: double.parse(amountController.text),
                            store: widget.storeModel,
                            products: PurchasedProductsScreen.products
                          );
                          if(error){
                            Snack.bottom('Error', 'Failed to send receipt');
                          }else{
                            Get.offAll(() => Home());
                            Snack.top('Success', 'Receipt Sent Successfully');
                          }
                          loadScreen();
                        }else{
                          Snack.top('Wait', 'Please Enter amount');
                        }
                      },
                      child: Text('Submit', style: TextStyle(color: AppConst.themePurple, fontFamily: 'Stag', fontSize: 14),),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    hintText: ' Enter Bill Amount',
                    hintStyle: TextStyle(fontFamily: 'open', fontWeight: FontWeight.w400, fontSize: 10, color: Color(0xff777C87)),
                    prefixText: '₹',
                    prefixStyle: TextStyle(fontFamily: 'open')
                ),
              ),
            );
          }),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.only(left: 10,bottom: 12),
            child: InkWell(
                onTap: (){
                  FocusScope.of(context).unfocus();
                  setState(() {
                    bottomDrawerIsOpen = !bottomDrawerIsOpen;
                  });
                },
                child: Text(
                  'Earn extra cashback',
                  style: TextStyle(fontSize: 14, fontFamily: 'Stag', color: AppConst.themePurple),
                )),
          )
        ],
      ),
    ),
  );
}

// class HorizontalListWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     PurchasedProductViewModel vm = Get.find();
//     return Expanded(
//       child: ListView.builder(
//         shrinkWrap: true,
//         padding: EdgeInsets.symmetric(
//           horizontal: 20,
//         ),
//         itemCount: vm.purchasedList.length,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (BuildContext context, int index){
//           var isSelected = false.obs;
//           return new Obx((){
//             return vm.purchasedList[index].product!=null?ProductCardWidget(
//               productModel: vm.purchasedList[index].product,
//               iconButton: IconButton(
//                 icon: Icon(!isSelected.value?Icons.add_circle_outline_rounded:FontAwesomeIcons.checkCircle, color: !isSelected.value?Colors.red:Colors.green, size: 22,),
//                 onPressed: (){
//                   isSelected.value = true;
//                   vm.purchasedList[index].count++;
//                 },
//               ),
//               quantityController: vm.purchasedList[index].count>0?Container(
//                 child: Row(
//                   children: [
//                     Flexible(
//                       flex: 1,
//                       child: InkWell(
//                         onTap: (){
//                           if(vm.purchasedList[index].count>1){
//                             vm.purchasedList[index].count--;
//                           }
//                           // vm.cartItemsWithQuantity.add(CartModel(count: 0));
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.only(topLeft: Radius.circular(3), bottomLeft: Radius.circular(3))
//                           ),
//                           padding: EdgeInsets.all(5),
//                           child: Center(
//                             child: Icon(Icons.remove, color: Colors.white, size: 12,),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Flexible(
//                       flex: 1,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.black,
//                         ),
//                         padding: EdgeInsets.all(5),
//                         child: Center(
//                           child: Text(vm.purchasedList[index].count.toString(), style: TextStyle(color: Colors.white, fontSize: 12),),
//                         ),
//                       ),
//                     ),
//                     Flexible(
//                       flex: 1,
//                       child: InkWell(
//                         onTap: (){
//                           vm.purchasedList[index].count++;
//                           print(vm.purchasedList[index].count);
//                           // vm.cartItemsWithQuantity.add(CartModel(count: 0));
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.only(topRight: Radius.circular(3), bottomRight: Radius.circular(3))
//                           ),
//                           padding: EdgeInsets.all(5),
//                           child: Center(
//                             child: Icon(Icons.add, color: Colors.white, size: 12,),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ):SizedBox(),
//             ):SizedBox();
//           });
//         },
//       ),
//     );
//   }
// }

class GridListWidget extends StatefulWidget {
  final String storeID;

  const GridListWidget({Key key, this.storeID}) : super(key: key);

  @override
  _GridListWidgetState createState() => _GridListWidgetState();
}

class _GridListWidgetState extends State<GridListWidget> {
  bool dataLoading = true;
  List<ProductModel> products = [];
  getData() async{
    products = await NewApi.getCashBackProducts(widget.storeID);
    setState(() {
      dataLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return products.length > 0 ? Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          /// number of child in a row
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: ((MediaQuery.of(context).size.width/2)/220),
        ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index){
          return Obx(() {
            bool isSelected = PurchasedProductsScreen.products.contains(products[index]);
            return GestureDetector(
                onTap: (){
                  if(isSelected){
                    PurchasedProductsScreen.products.remove(products[index]);
                  }else{
                    PurchasedProductsScreen.products.add(products[index]);
                  }

                },
                child: ProductCardWidget(data: products[index], isSelected: isSelected));
          });
        },
      ),
    ) : Expanded(
      child: Center(
        child: Text(
          'No Product Found'
        ),
      ),
    );
  }
}
