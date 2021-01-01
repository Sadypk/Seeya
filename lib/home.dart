import 'package:flutter/material.dart';

import 'features/home_screen/view/home_screen.dart';
import 'features/my_offers_screen/view/my_offers_screen.dart';
import 'features/profile_screen/view/profile_screen.dart';
import 'features/search_screen/view/search_screen.dart';
import 'main_app/resources/string_resources.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedScreen = 0;
  List<Widget> _buildScreens = <Widget>[
    HomeScreen(),
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
