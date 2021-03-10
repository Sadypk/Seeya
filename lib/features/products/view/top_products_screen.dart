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
            RawMaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              // onPressed: widget.onTapViewAll,
              onPressed: (){},
              child: InkWell(
                  onTap: (){Get.to(TopProductsScreen());},
                  child: Text('View All', style: TextStyle(color: Colors.blue),)
              ),
            )
          ],),

        Container(
          height: 175,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            itemCount: productList1.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductCardWidget(productModel: productList1[index], customAspectRatio: 6/4, );
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
          forYouProducts
        ],
      ),
    );
  }
}
