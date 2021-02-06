import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/store/models/store_model.dart';
import 'package:seeya/features/store/view/store_screen.dart';
import 'package:seeya/features/store/view_model/cart_view_model.dart';
import 'package:seeya/main_app/models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel productModel;
  final Function onTap;
  final IconButton iconButton;
  ProductCardWidget({this.productModel, this.onTap, this.iconButton});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(-1,1),
                  color: Colors.grey[300],
                  spreadRadius: 1,
                  blurRadius: 1
              ),
            ],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: Colors.grey[400])
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                  image: DecorationImage(
                    image: NetworkImage(productModel.productImage),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
            SizedBox(height: 2,),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('In Store', style: TextStyle(color: Colors.red, fontSize: 12),),
                              SizedBox(height: 2,),
                              Text(productModel.cashBack.toString()+' back', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                            ],
                          ),
                          if(iconButton !=null)iconButton
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Flexible(flex: 1,child: Text(productModel.productName, style: TextStyle(color: Colors.black54, fontSize: 13),)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}