import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/authentication/view/location_picker_screen.dart';

class PhoneVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(onPressed: (){
                Get.to(LocationPickerScreen());
              }, child: Text('Proceed'))
            ],
          ),
        ),
      ),
    );
  }
}
