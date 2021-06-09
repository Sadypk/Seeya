import 'package:flutter/material.dart';
import 'package:seeya/main_app/models/productModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/resources/string_resources.dart';

class ProductCardWidget extends StatefulWidget {
  final ProductModel data;
  final bool isSelected;
  const ProductCardWidget({Key key, this.data, this.isSelected = false}) : super(key: key);
  @override
  _ProductCardWidgetState createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 162,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(0xff707070).withOpacity(0.15)),
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          boxShadow: [
            AppConst.shadowBasic,
            AppConst.shadowBasic2
          ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 98,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4GhnC7WBjYbPhpTgGZUcOwteW5QyOunmCmZdWdQBIX8OZXnAXn379CSmrtJo0RyuJqwM&usqp=CAU'),
                    // image: CachedNetworkImageProvider(widget.data.logo),
                    fit: BoxFit.cover
                )
            ),
          ),
          Divider(thickness: 1, color: Colors.grey[300],),
          Container(
            height: 55,
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(widget.data.name, style: TextStyle(fontSize: 12, fontFamily: 'Stag', color: Color(0xff333333)),),
                ),
                Text('10% Cashback', style: TextStyle(color: Color(0xffEE175B), fontSize: 8, fontWeight: FontWeight.w600),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.data.sellingPrice.toString()+StringResources.rupee, style: AppConst.titleText1Purple,),
                    Icon(
                      widget.isSelected?Icons.check_circle:Icons.add_circle_outline,
                      color: widget.isSelected?AppConst.themePurple:Colors.red,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
