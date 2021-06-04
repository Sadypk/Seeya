import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/near_you/view/73_user_search_keyword_search_bar_product_view.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget.dart';
import 'package:seeya/main_app/resources/app_const.dart';

class UserSearchPage extends StatefulWidget {
  @override
  _UserSearchPageState createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  @override
  Widget build(BuildContext context) {
    Widget searchBox(String label){
      return Container(
        height: 25,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Color(0xff707070).withOpacity(0.25)),
        ),
        child: Center(
          child: Text(label, style: TextStyle(fontSize: 12, fontFamily: 'open', fontWeight: FontWeight.w400),),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff666666)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Color(0xff252525).withOpacity(0.4)),
                color: Colors.white
            ),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Icon(Icons.search, color: AppConst.black.withOpacity(0.7),)),
                Flexible(child: TextFormField(
                  // controller: searchController,
                  decoration: InputDecoration.collapsed(hintText: 'Search stores and products', hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'open', color: AppConst.black.withOpacity(0.7))),
                ))
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recently searched', style: AppConst.header2,),
                InkWell(
                    onTap: (){
                      Get.to(UserSearchKeywordSearchBarProductView());
                    },
                    child: Text('Clear', style: AppConst.descriptionTextPurple,))
              ],
            ),
          ),
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.only(left: 20),
            height: 25,
            child: ListView.builder(
              itemCount: 2,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index){
                return searchBox('Chicken');
              },
            ),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Trending near you', style: AppConst.header2,),
          ),
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.only(left: 20),
            height: 25,
            child: ListView.builder(
              itemCount: 8,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index){
                return searchBox('Mutton');
              },
            ),
          ),
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Recommended products for you', style: AppConst.header2,),
          ),
          SizedBox(height: 10,),
          Expanded(child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                /// number of child in a row
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: ((MediaQuery.of(context).size.width/2)/220),
              ),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index){
                return ProductCardWidget();
              },
            ),
          ))
        ],
      ),
    );
  }
}
