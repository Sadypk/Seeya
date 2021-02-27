import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageHelper{
  static Future<File> pickImage(ImageSource source) async{
    if(await Permission.mediaLibrary.request().isGranted){
      try{
        final pickedFile = await ImagePicker().getImage(source: source ?? ImageSource.gallery);
        if(pickedFile != null){
          final File file = File(pickedFile.path);
          final File croppedImage = await imageCropper(file);
          return croppedImage;
        }else{
          return null;
        }
      }catch(e){
        print(e.toString());
        return null;
      }
    }else{
      return null;
    }
  }

  static Future<File> imageCropper(File image) async{
    try{
      File croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
      );
      return croppedFile;
    }catch(e){
      print(e.toString());
      return image;
    }
  }


}