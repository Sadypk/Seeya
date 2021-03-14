import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/models/imgbb.dart';

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
              toolbarColor: AppConst.blue,
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

  static Future<String> uploadImage(File image) async{
    try{
      Dio dio = new Dio();
      ByteData bytes = await rootBundle.load(image.path);
      var buffer = bytes.buffer;
      var imgData = base64.encode(Uint8List.view(buffer));

      FormData formData = FormData.fromMap({
        "key" : "ecd00bd91ab62d061472c1e7162d5248",
        "image" :imgData
      });

      Response response = await dio.post(
          "https://api.imgbb.com/1/upload",
          data: formData
      );
      ImgbbResponseModel res = ImgbbResponseModel.fromJson(response.data);
      return res.data.displayUrl;
    }catch(e){
      if(e.runtimeType == DioError){
        DioError error = e;
        print(error.response);
        print(error.message);
      }else{
        print(e.toString());
      }
      /// if somehow upload fails this is the fallback image url
      return 'https://www.denofgeek.com/wp-content/uploads/2019/02/mcu-1-iron-man.jpg';
    }
  }
}