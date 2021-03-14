import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:seeya/mainRepoWithAllApi.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/main_app/util/customButton.dart';
import 'package:seeya/main_app/util/custom_textfield.dart';
import 'package:seeya/main_app/util/imagePicker.dart';
import 'package:seeya/main_app/util/screenLoader.dart';
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
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController dobController;
  TextEditingController genderController;

  //FocusNode
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();

  //image
  final picker = ImagePicker();
  File image;
  String gender;
  int dob;
  List<String> genders = ['Male', 'Female'];

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

  getDob() async{
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
    ).then((value) {
      dob = value.millisecondsSinceEpoch;
      dobController.text = DateFormat('dd MMM yyyy').format(value);
    });
  }

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: UserViewModel.user.value.firstName);
    lastNameController = TextEditingController(text: UserViewModel.user.value.lastName);
    emailController = TextEditingController(text: UserViewModel.user.value.email);
    dob = int.parse(UserViewModel.user.value.dateOfBirth);
    dobController = TextEditingController(text: DateFormat('dd MMM yyyy').format(DateTime(int.parse(UserViewModel.user.value.dateOfBirth))));
    gender = UserViewModel.user.value.maleOrFemale.trim().capitalize;
  }

  bool loading = false;
  screenLoading() => setState(()=>loading = !loading);

  @override
  Widget build(BuildContext context) {
    var imageWidget = Stack(
      clipBehavior: Clip.none,
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

    return IsScreenLoading(
      screenLoading: loading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
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
                  GestureDetector(
                    onTap: getDob,
                    child: CustomTextField(
                      enabled: false,
                      label: 'Date of Birth',
                      controller: dobController,
                      focusNode: dobFocusNode,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        value: gender,
                        onChanged: (val) => setState(()=>gender = val),
                        hint: Text('Select gender'),
                        items: genders.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  CustomButton(title: 'Submit', function: () async {
                    /// showing loading
                    /// do some validation checks if needed before loading
                    screenLoading();

                    String imageLink = UserViewModel.user.value.logo;
                    if(image!= null){
                      imageLink = await ImageHelper.uploadImage(image);
                    }

                    var result = await MainRepo.updateCustomerInfo(firstName: firstNameController.text, lastName: lastNameController.text, email:  emailController.text,image: imageLink,dob: dob.toString(),gender: gender);

                    screenLoading();

                    if(result != null){
                    print(result);
                  }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
