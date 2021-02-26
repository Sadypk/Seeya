import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/main_app/util/size_config.dart';


class CustomButton extends StatelessWidget {
  final String title;
  final Function function;
  final IconData icon;
  final Color color;
  final double width;
  final double height;
  final double textSize;
  final double radius;
  CustomButton({@required this.title, @required this.function, this.icon, this.color,this.width,this.height,this.textSize,this.radius});

  final GetSizeConfig sizeConfigController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: function,
      color: color?? Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius??sizeConfigController.width*20)),
      child: Container(
        height: height??45,
        width: width??Get.width,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon != null ? Icon(
                icon,
                size: sizeConfigController.height * 35,
                color: Colors.white,
              ): Text(''),
              icon != null ? SizedBox(width: sizeConfigController.width * 25,) : Text(''),
              Text(
                title,
                style: TextStyle(fontSize: textSize??20,color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}