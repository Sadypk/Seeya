import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class UserViewModel{
  static var userStatus = UserStatus.LOGGED_OUT.obs;
  static changeUserStatus (UserStatus status) => userStatus.value = status;


  ///  temp bt need to chat,
  static var user = User(
    id: '1',
    extraData: {
      'name' : 'tester one'
    }
  );
}

enum UserStatus{
  LOGGED_OUT,
  LOGGED_IN
}