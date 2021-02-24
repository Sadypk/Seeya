import 'package:get/get.dart';

class Snack{
  static bottom(String title, String message){
    Get.rawSnackbar(
        title: title,
        message: message
    );
  }

  static top(String title, String message){
    Get.snackbar(title, message);
  }
}