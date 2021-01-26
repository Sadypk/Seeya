import 'package:get/get.dart';

class GetSizeConfig extends GetxController{
  RxDouble width = 0.0.obs;
  RxDouble height = 0.0.obs;

  setSize(w,h){
    width.value = w;
    height.value = h;
  }

  getPixels(w){
    return width.value * w/width.value;
  }
}