import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/products_tile_widget.dart';
import 'package:seeya/features/home_screen/view_models/top_products_view_model.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget.dart';

class TopProductsScreen extends StatefulWidget {
  @override
  _TopProductsScreenState createState() => _TopProductsScreenState();
}

class _TopProductsScreenState extends State<TopProductsScreen> {
  @override
  Widget build(BuildContext context) {
    var productList1 = TopProductsViewModel().productList;
    var forYouProducts = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text('Top Products',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],),
        SizedBox(height: 10,),
        Container(
          height: 175,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            itemCount: productList1.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductCardWidget(productModel: productList1[index], customAspectRatio: 6/4, customImageAspectRatio: 20/9,);
            },
          ),
        ),
      ],
    );

    var hotProducts = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text('Hot Products', style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],),
        SizedBox(height: 10,),
        Container(
          height: 175,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductCardWidget(productModel: productList1[0]);
            },
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: 175,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductCardWidget(productModel: productList1[0]);
            },
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Top Products'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          forYouProducts,
          SizedBox(height: 25,),
          hotProducts
        ],
      ),
    );
  }
}
