import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seeya/main_app/models/productModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/resources/string_resources.dart';

class ProductCardWidget extends StatefulWidget {
  final ProductModel data;
  final bool isSelected;
  const ProductCardWidget({Key key, this.data, this.isSelected}) : super(key: key);
  @override
  _ProductCardWidgetState createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 164,
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(widget.data.name, style: TextStyle(fontSize: 12, fontFamily: 'Stag', color: Color(0xff333333)),),
                      Text('10% Cashback', style: TextStyle(color: Color(0xffEE175B), fontSize: 8, fontWeight: FontWeight.w600),),
                      Text(widget.data.sellingPrice.toString()+StringResources.rupee, style: AppConst.titleText1Purple,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

        if(widget.isSelected)Positioned(
          bottom: 34,
          right: 16,
          child: Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
        )
      ],
    );
  }
}
