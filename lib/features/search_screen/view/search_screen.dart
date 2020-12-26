import 'package:flutter/material.dart';
import 'package:seeya/main_app/view/widgets/commonGreyButton.dart';
import 'package:seeya/main_app/view/widgets/custom_text_from_field.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin{
  TabController _controller;
  int _selectedIndex= 0;
  @override
  void initState() {
    // TODO: implement initState
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var searchBox = Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey[300], width: 1),
        boxShadow: [
          BoxShadow(
              color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
          BoxShadow(
              color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 5,),
          Icon(Icons.search, size: 20, color: Colors.grey,),
          SizedBox(width: 5,),
          Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    hintText: 'Search'
                ),
              )
          )
        ],
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Column(
            children: [
              searchBox,
              SizedBox(height: 15,),
              CommonGreyButton(
                width: 200,
                label: 'Search Stores',
                icon: Icons.store,
              ),
              SizedBox(height: 10,),
              CommonGreyButton(
                width: 200,
                label: 'Search Products',
                icon: Icons.category,
              ),
              Expanded(child: ListView(
                children: [
                  TabBar(
                    tabs: [
                      Tab(child: Text('Stores', style: TextStyle(color: Colors.black),),),
                      Tab(child: Text('Products', style: TextStyle(color: Colors.black),),)
                    ],
                    controller: _controller,
                  ),
                  Container(
                    height: 100,
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        Icon(Icons.add),
                        Icon(Icons.remove),
                      ]
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
