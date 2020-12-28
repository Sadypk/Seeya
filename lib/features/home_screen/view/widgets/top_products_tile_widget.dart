import 'package:flutter/material.dart';
import 'package:seeya/main_app/models/product_model.dart';

class TopProductsTileWidget extends StatelessWidget {
  final ProductModel productModel;
  TopProductsTileWidget({this.productModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0,1)
          )
        ]
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            width: 160,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              child: Image.network(productModel.productImage, fit: BoxFit.cover,)),
          ),
          Text(productModel.productName, style: TextStyle(),)
        ],
      ),
    );
  }
}
