// import 'package:p7app/main_app/resource/strings_resource.dart';
// import 'package:p7app/method_extension.dart';
//
// class Validator {
//   String nullFieldValidate(String value) =>
//       value.isEmptyOrNull ? StringResources.thisFieldIsRequired : null;
//
//
//
//
//
//   String validateEmail(String value) {
//     Pattern pattern =
//         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//     RegExp regex = new RegExp(pattern);
//
//     if (value.isEmpty) {
//       return StringResources.pleaseEnterEmailText;
//     }else if (!regex.hasMatch(value))
//       return StringResources.pleaseEnterAValidEmailText;
//     else
//       return null;
//   }
//
//   String validatePassword(String value) {
//     final RegExp _passwordRegExp = RegExp(
//       r'(?=.*?[0-9])(?=.*?[A-Za-z]).+',
//     );
//     if (value.isEmpty) {
//       return StringResources.thisFieldIsRequired;
//     } else if (value.length<8) {
//       return StringResources.passwordMustBeEight;
//     }else if (!_passwordRegExp.hasMatch(value)) {
//       return StringResources.passwordRequirementText;
//     } else {
//       return null;
//     }
//   }
//
//   String validateEmptyPassword(String value) {
//     if (value.isEmpty) {
//       return StringResources.pleaseEnterPasswordText;
//     }  else {
//       return null;
//     }
//   }
//
//   String validateConfirmPassword(String password, String confirmPassword) {
//     if (password != confirmPassword) {
//       return StringResources.passwordDoesNotMatch;
//     } else {
//       return null;
//     }
//   }
//
//   String validatePhoneNumber(String value) {
// //    Pattern pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
//     Pattern pattern = r'\+?(88)?0?1[3456789][0-9]{8}\b';
//     RegExp regex = new RegExp(pattern);
//     if(value == ''){
//       return null;
//     }else if(value.length > 11){
//       return StringResources.enterValidPhoneNumber;
//     }else if (!regex.hasMatch(value))
//       return StringResources.enterValidPhoneNumber;
//     else
//       return null;
//   }
//
//   String validatePhoneNumberForVerification(String value) {
// //    Pattern pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
//     Pattern pattern = r'\+?(88)?0?1[3456789][0-9]{8}\b';
//     RegExp regex = new RegExp(pattern);
//     if(value == ''){
//       return StringResources.phoneVerificationEnterValidPhoneNumber;
//     }else if(value.length > 11){
//       return StringResources.phoneVerificationEnterValidPhoneNumber;
//     }else if (!regex.hasMatch(value))
//       return StringResources.phoneVerificationEnterValidPhoneNumber;
//     else
//       return null;
//   }
//
//   String verificationCodeValidator(String value) {
//     Pattern pattern = r'^(\d{6})?$';
//     RegExp regex = new RegExp(pattern);
//     if (!regex.hasMatch(value))
//       return StringResources.invalidCode;
//     else
//       return null;
//   }
//
//    String numberFieldValidateOptional(String value){
//     Pattern pattern = r'^[1-9]\d*(\.\d+)?$';
//     RegExp regex = new RegExp(pattern);
//     if(value.isEmpty){
//       return null;
//     }
//
//     if (!regex.hasMatch(value))
//       return StringResources.pleaseEnterDecimalValue;
//     else
//       return null;
//   }
//
//
//   String nameValidator(String value){
//     Pattern pattern = '/[a-zA-Z]/i';
//     RegExp regExp = new RegExp(pattern);
//     if(value.length > 0){
//       if(!regExp.hasMatch(value)){
//         return StringResources.invalidName;
//       }else{
//         return null;
//       }
//     }else{
//       return StringResources.thisFieldIsRequired;
//     }
//   }
//
//   String expertiseFieldValidate(String value){
//     double x;
//     Pattern pattern = r'^([0-9]{1,2})+(\.[0-9]{1,2})?$';
//     RegExp regex = new RegExp(pattern);
//     if(value.isEmpty){
//       return StringResources.thisFieldIsRequired;
//     }else {
//       if(!regex.hasMatch(value)){
//         return StringResources.twoDecimal;
//       }else{
//         x = double.parse(value);
//         if(x >=0 && x <11){
//           return null;
//         }else{
//           return StringResources.valueWithinRange;
//         }
//       }
//     }
//   }
//
// }
