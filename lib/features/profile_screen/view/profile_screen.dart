import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
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
            Text('Name',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
          title: Text('Invite Friends'),
          leading: Icon(Icons.person_add_alt_1_outlined),
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
              color: Colors.white
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
