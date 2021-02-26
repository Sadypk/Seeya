import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageHelper{
  static Future<File> pickImage(ImageSource source) async{
    if(await Permission.mediaLibrary.request().isGranted){
      try{
        final pickedFile = await ImagePicker().getImage(source: source ?? ImageSource.gallery);
        if(pickedFile != null){
          final File file = File(pickedFile.path);
          return file;
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
}