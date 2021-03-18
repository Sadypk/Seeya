import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';


class TheBossCameraScreen extends StatefulWidget {
  static List<CameraDescription> cameras;
  @override
  _TheBossCameraScreenState createState() => _TheBossCameraScreenState();
}

class _TheBossCameraScreenState extends State<TheBossCameraScreen> {

  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(TheBossCameraScreen.cameras[0], ResolutionPreset.ultraHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }
  final Duration _duration = Duration(milliseconds: 200);
  final images = [];
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan receipt'
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedCrossFade(
              firstChild: _buildCameraView(),
              secondChild: _buildImageList(),
              crossFadeState: !isDone ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: _duration),
          ),
          AnimatedCrossFade(
            firstChild: _buildCameraButtons(),
            secondChild: _buildInputPriceButtons(),
            crossFadeState: !isDone ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: _duration),
        ],
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(
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
        ),

        InkWell(
          onTap: () async{
            XFile image = await controller.takePicture();
            File file = File(image.path);
            setState(() {
              images.add(file);
            });
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

        InkWell(
          onTap: (){
            setState(() {
              isDone = !isDone;
            });
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
        )
      ],
    ),
  );


  _buildImageList() => ListView(
    shrinkWrap: true,
    children: images.map((e) => Image.file(e)).toList(),
  );
  _buildInputPriceButtons() => Container(
    color: Colors.white,
    height: 100,
    width: Get.width,
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width * .5,
              height: 50,
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
              ),
            ),
            TextButton(
              onPressed: (){},
              child: Text(
                'Apply coupon'
              ),
            )
          ],
        ),

        InkWell(
          onTap: (){
            setState(() {
              isDone = !isDone;
            });
          },
          child: Container(
            width: 90,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6)
            ),
            child: Center(
              child: Text(
                'Submit',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}