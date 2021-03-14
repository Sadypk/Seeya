import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seeya/main_app/models/userModel.dart';

class UserViewModel{
  static var userStatus = UserStatus.LOGGED_OUT.obs;
  static changeUserStatus (UserStatus status) => userStatus.value = status;

  static var user = UserModel().obs;
  static setUser(UserModel data) => user.value = data;

  static var token = ''.obs;
  static setToken(String data) => token.value = data;

  static var currentLocation = LatLng(0.0, 0.0).obs;
  static setLocation(LatLng latLng) => currentLocation.value = latLng;
}

enum UserStatus{
  LOGGED_OUT,
  LOGGED_IN
}