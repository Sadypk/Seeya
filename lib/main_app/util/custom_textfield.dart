import 'package:flutter/material.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/util/size_config.dart';
import 'package:get/get.dart';


class CustomTextField extends StatefulWidget {
  final String label;
  final String prefix;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final Function onChanged;
  final Function onSubmit;
  final FocusNode focusNode;

  CustomTextField({this.controller, this.label, this.onChanged, this.keyBoardType, this.focusNode, this.prefix, this.onSubmit});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5,),
      child: TextField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        keyboardType: TextInputType.number,
        focusNode: widget.focusNode,
        onSubmitted: widget.onSubmit,
        // inputFormatters: [LengthLimitingTextInputFormatter(11)],
        decoration: InputDecoration(
          prefixText: widget.prefix,
          prefixStyle: TextStyle(color: Colors.black, fontSize: 16),
          contentPadding: EdgeInsets.symmetric(
              vertical: 5, horizontal: 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppConst.black,
              )
          ),
          labelText: widget.label,
        ),
      ),
    );
  }
}
