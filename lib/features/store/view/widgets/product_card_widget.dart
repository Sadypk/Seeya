import 'package:flutter/material.dart';
import 'package:seeya/main_app/resources/app_const.dart';

class ProductCardWidget extends StatefulWidget {
  @override
  _ProductCardWidgetState createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Text('Chocolate', style: TextStyle(fontSize: 12, fontFamily: 'Stag', color: Color(0xff333333)),),
                  Text('10% Cashback', style: TextStyle(color: Color(0xffEE175B), fontSize: 8, fontWeight: FontWeight.w600),),
                  Text('1,500₹', style: AppConst.titleText1Purple,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
