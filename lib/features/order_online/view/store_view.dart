import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/scan_receipt/view/purchased_products_screen.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget.dart';
import 'package:seeya/main_app/models/productModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';

import '../../../newMainAPIs.dart';

class StoreView extends StatefulWidget {
  final BoomModel data;

  const StoreView({Key key, this.data}) : super(key: key);
  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${widget.data.name}', style: TextStyle(color: Colors.white, fontSize: 16)),
                Text('(${widget.data.defaultCashbackOffer}% cashback)', style: TextStyle(color: Colors.white, fontSize: 11)),
              ],
            ),
            Text('Wallet balance: ${widget.data.defaultCashbackOffer}', style: TextStyle(color: Colors.white, fontSize: 14)),
          ],
        )
      ),
      body: Column(
        children: [
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
                  controller: searchController,
                  decoration: InputDecoration.collapsed(hintText: 'Enter any product name here', hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'open', color: AppConst.black.withOpacity(0.7))),
                ))
              ],
            ),
          ),
       /*   ButtonsTabBar(
            physics: AlwaysScrollableScrollPhysics(),
            backgroundColor: Color(0xff252525),
            unselectedBackgroundColor: Colors.white,
            unselectedLabelStyle: TextStyle(color: Color(0xff252525)),
            radius: 20,
            borderColor: Color(0xff707070),
            unselectedBorderColor: Color(0xff707070),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            borderWidth: 1,
            labelStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                text: "All",
              ),
              Tab(
                text: "Grocery",
              ),
              Tab(
                text: "Fresh",
              ),
              Tab(
                text: "Restaurant",
              ),
              Tab(
                text: "Pharmacy",
              ),
            ],
          ),*/
          SizedBox(
            height: 15,
          ),
          GridListWidget(storeID: widget.data.id)
        ],
      ),
    );
  }
}


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
