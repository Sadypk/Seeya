import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:seeya/features/scan_receipt/view/purchased_products_screen.dart';
import 'dart:io';

import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/mainRepoWithAllApi.dart';
import 'package:seeya/main_app/resources/string_resources.dart';
import 'package:seeya/newMainAPIs.dart';


RxBool flashOn = false.obs;
RxBool longReceipt = false.obs;
RxBool camLoading = false.obs;
RxList images = <File>[].obs;


class TheBossCameraScreen extends StatefulWidget {
  final StoreData storeModel;
  TheBossCameraScreen({this.storeModel});
  static List<CameraDescription> cameras;
  @override
  _TheBossCameraScreenState createState() => _TheBossCameraScreenState();
}

class _TheBossCameraScreenState extends State<TheBossCameraScreen> {
  CameraController controller;


  @override
  void initState() {
    flashOn.value = false;
    longReceipt.value = false;
    camLoading.value = false;
    images.clear();
    super.initState();
    controller = CameraController(
        TheBossCameraScreen.cameras[0],
        ResolutionPreset.high,
        enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        controller.setFlashMode(FlashMode.off);
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {
        MainRepo.logger.e(cameraController.value.errorDescription);
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      MainRepo.logger.e(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          StringResources.cameraViewAppBarTitle,
          style: TextStyle(
            fontFamily: 'Stag',
            fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx((){
              if(longReceipt.value){
                return _buildFlashController();
              }else{
                return SizedBox();
              }
            }),
            _buildCameraView(),
            _buildCameraButtons()
          ],
        ),
      ),
    );
  }


  _buildFlashController(){
    return Obx(()=>Container(
      height: 50,
      color: Colors.black,
      child: Center(
        child: IconButton(
          onPressed: (){
            flashOn.value = !flashOn.value;
            controller.setFlashMode(flashOn.value?FlashMode.always:FlashMode.off);
          },
          icon: Icon(!flashOn.value?Icons.flash_off_rounded:Icons.flash_on_rounded, color: Colors.white,),
        ),
      ),
    ));
  }

  _buildCameraView() {
    return Expanded(
      flex: 33,
      child: CameraPreview(
        controller,
      ),
    );
  }

  _buildCameraButtons() => Column(
    children: [
      SizedBox(height: 8),
      GestureDetector(
        onTap: (){},
        child: Text(
          StringResources.cameraViewBtnAddLater,
          style: TextStyle(
              fontSize: 12,
              fontFamily: 'open',fontWeight: FontWeight.w600,
              color: Colors.white
          ),
        ),
      ),

      Container(
        color: Colors.black,
        height: 100,
        width: Get.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Obx(()=>SizedBox(
              height: 100,
              width: 50,
              child: longReceipt.value ?
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 100,
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white,
                            width: 2
                        )
                    ),
                    child: images.length > 0 ? Image.file(images.last) : SizedBox.expand(),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent
                      ),
                      padding: EdgeInsets.all(6),
                      child: Text(
                        '${images.length}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
              )
                  :
              Column(
                children: [
                  IconButton(
                    onPressed: (){
                      flashOn.value = !flashOn.value;
                      controller.setFlashMode(flashOn.value?FlashMode.always:FlashMode.off);
                    },
                    icon: Icon(Icons.flash_auto, color: Colors.white,),
                  ),
                  SizedBox(height: 5,),
                  Text(StringResources.cameraViewBtnFlash, style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: 'open', fontWeight: FontWeight.w600),)
                ],
              )
            )),

            Obx(()=>SizedBox(
              height: 70,
              width: 70,
              child: InkWell(
                onTap: () async{
                  camLoading.value = !camLoading.value;
                  print('here??');
                  XFile image;
                  try{
                    image = await controller.takePicture();
                  }catch(e){
                    print('e.toString()');
                    print(e.toString());
                  }

                  File file = File(image.path);


                  if(longReceipt.value){

                      camLoading.value = !camLoading.value;
                      images.add(file);
                  }else{
                    images.add(file);
                    camLoading.value = !camLoading.value;
                    Get.off(PurchasedProductsScreen(storeModel: widget.storeModel), arguments: images);
                  }
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white,
                          width: 2
                      )
                  ),
                  child: camLoading.value ? CircularProgressIndicator() : Container(
                    height: 70,
                    width: 70,
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            )),

            Obx(()=>longReceipt.value?InkWell(
              onTap: (){
                Get.off(PurchasedProductsScreen(storeModel: widget.storeModel), arguments: images);
              },
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: 90,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(6)
                ),
                child: Center(
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ):Column(
              children: [
                IconButton(
                  onPressed: (){
                    longReceipt.value = !longReceipt.value;
                  },
                  icon: Icon(Icons.receipt_long_rounded, color: Colors.white,),
                ),
                SizedBox(height: 5,),
                Text(StringResources.cameraViewBtnLongBill, style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: 'open', fontWeight: FontWeight.w600),)
              ],
            ))
          ],
        ),
      ),
    ],
  );
}