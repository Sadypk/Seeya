import 'package:flutter/material.dart';
import 'package:seeya/main_app/view/widgets/commonGreyButton.dart';
import 'package:seeya/main_app/view/widgets/custom_text_from_field.dart';

class SearchScreen extends StatelessWidget {
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
    return SafeArea(
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

              ],
            ))
          ],
        ),
      ),
    );
  }
}
