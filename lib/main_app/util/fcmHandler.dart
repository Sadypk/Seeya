import 'package:firebase_messaging/firebase_messaging.dart';

class FCMHandler{
  static String fcmToken;

  static init() async{
    print('FCM INITIALIZED');
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    fcmToken = await _firebaseMessaging.getToken();

    /// while app is on
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage');
      print(message.data);
    });

    /// on close notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp');
      print(message.data);
    });

  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    print('_backgroundMessageHandler');
    print(message.data);
  }
}