import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/util/customButton.dart';
import 'package:seeya/main_app/util/imagePicker.dart';

import 'purchased_products_screen.dart';

class ScanReceiptScreen extends StatefulWidget {
  final StoreModel storeModel;

  const ScanReceiptScreen({Key key, this.storeModel}) : super(key: key);
  @override
  _ScanReceiptScreenState createState() => _ScanReceiptScreenState();
}

class _ScanReceiptScreenState extends State<ScanReceiptScreen> {
  List<File> images = [];
  List<Asset> assets = [];

  pickImage() async{
    File temp = await ImageHelper.pickImage(ImageSource.camera);
    if(temp == null){
      
    }else{
      setState(() {
        images.add(temp);
      });
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];
    String error = 'No Error Dectected';

    if(await Permission.mediaLibrary.request().isGranted){
      try {
        resultList = await MultiImagePicker.pickImages(
          maxImages: 5,
          enableCamera: true,
          selectedAssets: assets,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            actionBarColor: "#abcdef",
            actionBarTitle: "Example App",
            allViewTitle: "All Photos",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
          ),
        );
      } on Exception catch (e) {
        error = e.toString();
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      setState(() {
        assets = resultList;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    pickImage();
    // loadAssets();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan receipt',
          style: TextStyle(
            color: Colors.blueAccent
          ),
        ),
        actions: [
          TextButton(
            onPressed: (){
              Get.off(()=> PurchasedProductsScreen(storeModel: widget.storeModel,), arguments: images);
            },
            child: Text(
              'Next'
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: images.length,
          shrinkWrap: true,
          itemBuilder: (_, index) => Image.file(images[index]),
          // itemBuilder: (_, index) => AssetThumb(asset: assets[index],height: (Get.height * .7).toInt(), width: (Get.width).toInt()),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomButton(
          color: AppConst.themeBlue,
          title: 'Take Another',
          function: () async{
            await pickImage();
          },
        ),
      )
    );
  }
}
