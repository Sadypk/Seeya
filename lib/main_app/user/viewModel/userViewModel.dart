import 'package:get/get.dart';
import 'package:seeya/main_app/models/userModel.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class UserViewModel{
  static var userStatus = UserStatus.LOGGED_OUT.obs;
  static changeUserStatus (UserStatus status) => userStatus.value = status;

  static var user = UserModel().obs;
  static setUser(UserModel data) => user.value = data;

  static var token = ''.obs;
  static setToken(String data) => token.value = data;
}

enum UserStatus{
  LOGGED_OUT,
  LOGGED_IN
}