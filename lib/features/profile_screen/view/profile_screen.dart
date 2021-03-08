import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/profile_screen/view/profile_edit.dart';
import 'package:seeya/main_app/models/userModel.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel user;

  @override
  void initState() {
    user = UserViewModel.user.value;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var userHeader = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white38
          ),
          child: Center(
            child: Icon(Icons.person, size: 40,),
          ),
        ),
        SizedBox(width: 15,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${user.firstName} ${user.lastName}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text('1,234\$',style: TextStyle(fontSize: 30),),
            Text('Lifetime earning',style: TextStyle(fontSize: 15),),
          ],
        ),
      ],
    );

    var withdrawCashButton = Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Withdraw Cash', style: TextStyle(fontWeight: FontWeight.bold),),
          Text('\$17 available'),
        ],
      ),
    );

    var listOptions = ListView(
      children: [
        ListTile(
          title: Text('Edit Profile'),
          leading: Icon(Icons.person),
          onTap: (){Get.to(ProfileEditScreen());},
        ),
        ListTile(
          title: Text('Invite Friends'),
          leading: Icon(Icons.group_add),
        ),
        ListTile(
          title: Text('Invite Stores'),
          leading: Icon(Icons.store_sharp),
        ),
        ListTile(
          title: Text('Settings'),
          leading: Icon(Icons.settings),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
              color: Colors.grey[100]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  userHeader,
                  SizedBox(height: 15,),
                  withdrawCashButton,
                ],
              ),
            ),
            Expanded(
              child: listOptions,
            )
          ],
        ),
      ),
    );
  }
}
