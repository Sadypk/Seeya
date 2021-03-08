import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:seeya/mainRepoWithAllApi.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/main_app/util/customButton.dart';
import 'package:seeya/main_app/util/custom_textfield.dart';
import 'package:seeya/main_app/util/size_config.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  //state
  final GetSizeConfig sizeConfig = Get.find();
  bool edit = false;
  bool isLoading = false;

  //Text Controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  //FocusNode
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  //image
  final picker = ImagePicker();
  File image;

  showDialog(context) {
    Get.dialog(CupertinoAlertDialog(
      title: Text('Camera Permission'),
      content: Text(
          'App requires photo storage permission to access in gallery'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Deny'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        CupertinoDialogAction(
          child: Text('Settings'),
          onPressed: () async {
            var dialogCloser = await openAppSettings();
            if(dialogCloser != null){
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    ));
  }

  void selectPic() async {
    if(await Permission.photos.request().isGranted){
      try {
        final pickedFile = await picker.getImage(source: ImageSource.gallery);
        setState(() {
          if (pickedFile != null) {
            image = File(pickedFile.path);
          } else {
            print('No image selected.');
          }
        });
      } catch (e) {
        showDialog(context);
        print(e.toString());
      }
    }
    else{
      showDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var imageWidget = Stack(
      overflow: Overflow.visible,
      children: [
        CircleAvatar(
            radius: 80,
            backgroundImage: image == null ? CachedNetworkImageProvider(UserViewModel.user.value.logo??'assets/images/dummy_image_1.jpg') : FileImage(image)),
        Positioned(
          bottom: 0,
          left: 100,
          right: 0,
          child: GestureDetector(
            onTap: selectPic,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              child: Icon(
                  Icons.camera, color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imageWidget,
              SizedBox(height: 30,),
              CustomTextField(
                label: 'First Name',
                controller: firstNameController,
                focusNode: firstNameFocusNode,
                onSubmit: (v){lastNameFocusNode.requestFocus();},
              ),
              CustomTextField(
                label: 'Last Name',
                controller: lastNameController,
                focusNode: lastNameFocusNode,
                onSubmit: (v){emailFocusNode.requestFocus();},
              ),
              CustomTextField(
                label: 'Email',
                controller: emailController,
                focusNode: emailFocusNode,
              ),
              SizedBox(height: 20,),
              CustomButton(title: 'Submit', function: () async {
                var result = await MainRepo.updateCustomerInfo(firstName: firstNameController.text, lastName: lastNameController.text, email:  emailController.text,image: '',dob: '',gender: '',address: 'toilet',lat: 1212.12,lng:23123.00);
              if(result != null){
                print(result);
              }
              })
            ],
          ),
        ),
      ),
    );
  }
}
