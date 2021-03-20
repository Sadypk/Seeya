import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:seeya/features/scan_receipt/view/purchased_products_screen.dart';
import 'dart:io';

import 'package:seeya/features/store/models/storeModel.dart';


class TheBossCameraScreen extends StatefulWidget {
  final StoreModel storeModel;
  TheBossCameraScreen({this.storeModel});
  static List<CameraDescription> cameras;
  @override
  _TheBossCameraScreenState createState() => _TheBossCameraScreenState();
}

class _TheBossCameraScreenState extends State<TheBossCameraScreen> {
  CameraController controller;
  bool flashOn = false;
  bool longReceipt = false;

  @override
  void initState() {
    super.initState();
    controller = CameraController(TheBossCameraScreen.cameras[0], ResolutionPreset.ultraHigh,);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        controller.setFlashMode(FlashMode.off);
      });
    });
  }
  final Duration _duration = Duration(milliseconds: 200);
  final List<File> images = [];
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Scan receipt'
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            if(longReceipt)_buildFlashController(),
            Expanded(
              child: _buildCameraView(),
            ),
            _buildCameraButtons()
          ],
        ),
      ),
    );
  }


  _buildFlashController(){
    return Container(
      height: 50,
      color: Colors.black,
      child: Center(
        child: IconButton(
          onPressed: (){
            setState(() {
              flashOn = !flashOn;
              controller.setFlashMode(flashOn?FlashMode.always:FlashMode.off);
            });
          },
          icon: Icon(!flashOn?Icons.flash_off_rounded:Icons.flash_on_rounded, color: Colors.white,),
        ),
      ),
    );
  }
  _buildCameraView() => CameraPreview(
    controller,
  );
  _buildCameraButtons() => Container(
    color: Colors.black,
    height: 100,
    width: Get.width,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        longReceipt?Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white,
                      width: 2
                  )
              ),
              child: images.length > 0 ? Expanded(child: Image.file(images.last)) : SizedBox.expand(),
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
        ):IconButton(
          onPressed: (){
            setState(() {
              flashOn = !flashOn;
              controller.setFlashMode(flashOn?FlashMode.always:FlashMode.off);
            });
          },
          icon: Icon(!flashOn?Icons.flash_off_rounded:Icons.flash_on_rounded, color: Colors.white,),
        ),

        InkWell(
          onTap: () async{
            XFile image = await controller.takePicture();
            File file = File(image.path);
            if(longReceipt){
              setState(() {
                images.add(file);
              });
            }else{
              images.add(file);
              Get.off(PurchasedProductsScreen(storeModel: widget.storeModel,), arguments: images);
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
            child: Container(
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

        longReceipt?InkWell(
          onTap: (){
            Get.off(PurchasedProductsScreen(storeModel: widget.storeModel,), arguments: images);
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
              onPressed: (){setState(() {
                longReceipt = !longReceipt;
              });},
              icon: Icon(Icons.receipt_long_rounded, color: Colors.white,),
            ),
            SizedBox(height: 5,),
            Text('Long Receipt', style: TextStyle(color: Colors.white),)
          ],
        )
      ],
    ),
  );
}