import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageHelper{
  static pickImage(ImageSource source) async{
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
    }
  }
}