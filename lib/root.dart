import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seeya/features/home_screen/view/home_screen.dart';
import 'package:seeya/features/my_offers_screen/view/my_offers_screen.dart';
import 'package:seeya/features/profile_screen/view/profile_screen.dart';
import 'package:seeya/features/search_screen/view/search_screen.dart';
import 'package:seeya/main_app/resources/string_resources.dart';
import 'package:get/get.dart';

class Root extends StatefulWidget{

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int _selectedScreen = 0;
  List<Widget> _buildScreens = <Widget>[
    HomeScreen(),
    SearchScreen(),
    SearchScreen(),
    MyOffersScreen(),
    ProfileScreen()
  ];
  List<BottomNavigationBarItem> _navBarsItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: (StringResources.rootScreenHomeText),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: (StringResources.rootScreenSearchText),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_shopping_cart),
      label: (StringResources.rootScreenMyOffersText),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: (StringResources.rootScreenProfileText),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<String> _appbarTitleList = <String>[
      StringResources.rootScreenHomeText,
      StringResources.rootScreenSearchText,
      StringResources.rootScreenMyOffersText,
      StringResources.rootScreenProfileText
    ];

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedScreen,
        onTap: (int v){setState(() {
          _selectedScreen = v;
        });},
        items: _navBarsItems,
      ),
      body: _buildScreens[_selectedScreen],
    );
  }
}

