import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:seeya/features/scan_receipt/theBoss/view/cameraView.dart';
import 'package:seeya/main_app/util/fcmHandler.dart';
import 'package:seeya/root.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'features/chat/repository/streachatConfig.dart';
import 'main_app/resources/app_const.dart';
import 'main_app/util/size_config.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  TheBossCameraScreen.cameras = await availableCameras();
  await GetStorage.init();
  await Firebase.initializeApp();
  await FCMHandler.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(GetSizeConfig());

    final newTextTheme = Theme.of(context).textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
        fontFamily: 'Comfortaa-Regular'
    );

    return GetMaterialApp(
      title: 'Storebill Customer',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Comfortaa-Regular',
          textTheme: newTextTheme,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: AppConst.blue,
          appBarTheme: AppBarTheme(
              elevation: 0,
              color: AppConst.themePurple,
              centerTitle: false,
              titleTextStyle: AppConst.appbarTextStyle,
              iconTheme: IconThemeData(
                  color: Colors.black
              )
          )
      ),
      builder: (context, child) {
        return StreamChat(
          client: SConfig.client,
          child: child,
        );
      },
      home: Root(),
      // home: Home(),
    );
  }
}
