import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/root.dart';

import 'main_app/resources/app_const.dart';
import 'main_app/util/size_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'Flutter Demo',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Comfortaa-Regular',
          textTheme: newTextTheme,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: AppConst.blue,
          appBarTheme: AppBarTheme(
              elevation: 0,
              color: Colors.transparent,
              centerTitle: false,
              iconTheme: IconThemeData(
                  color: Colors.black
              )
          )
      ),
      home: Root(),
    );
  }
}
