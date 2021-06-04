import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view/widgets/store_shop_now_tile.dart';
import 'package:seeya/features/near_you/view/72_user_search_page.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/view/widgets/custom_outline_button.dart';
import 'package:seeya/main_app/view/widgets/square_image_widget.dart';

class NearYou extends StatefulWidget {
  @override
  _NearYouState createState() => _NearYouState();
}

class _NearYouState extends State<NearYou> {
  String dropdownValue = 'One';
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(FeatherIcons.mapPin, color: Colors.white, size: 16,),
            SizedBox(width: 5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Home', style: AppConst.appbarTextStyle,),
                Text('123, Your street address, City name, Country.', style: TextStyle(fontSize: 10, fontFamily: 'open', color: Color(0xffEBEBEB),), overflow: TextOverflow.ellipsis,)
              ],
            )
          ],
        ),
        actions: [
          Row(
            children: [
              Icon(FeatherIcons.gift, color: Colors.white, size: 15,),
              SizedBox(width: 3,),
              Text('Refer & Earn 25', style: TextStyle(fontSize: 10, fontFamily: 'open', color: Color(0xffEBEBEB)),),
              SizedBox(width: 5)
            ],
          )
        ],
      ),

      body: Column(
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
                  controller: searchController,
                  decoration: InputDecoration.collapsed(hintText: 'Search stores and products', hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'open', color: AppConst.black.withOpacity(0.7))),
                ))
              ],
            ),
          ),
          SizedBox(height: 15,),
          Container(
            height: 55,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SquareImageWidget(title: 'Adidas', image: 'https://i.pinimg.com/originals/b6/e2/ef/b6e2ef894ef8e63a8a3e8c35a6e6144a.png',),
                SquareImageWidget(title: 'Adidas', image: 'https://i.pinimg.com/originals/b6/e2/ef/b6e2ef894ef8e63a8a3e8c35a6e6144a.png',),
                SquareImageWidget(title: 'Adidas', image: 'https://i.pinimg.com/originals/b6/e2/ef/b6e2ef894ef8e63a8a3e8c35a6e6144a.png',),
                SquareImageWidget(title: 'Adidas', image: 'https://i.pinimg.com/originals/b6/e2/ef/b6e2ef894ef8e63a8a3e8c35a6e6144a.png',),
              ],
            ),
          ),
          SizedBox(height: 12,),
          Container(
            height: 55,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SquareImageWidget(title: 'Adidas', image: 'https://i.pinimg.com/originals/b6/e2/ef/b6e2ef894ef8e63a8a3e8c35a6e6144a.png',),
                SquareImageWidget(title: 'Adidas', image: 'https://i.pinimg.com/originals/b6/e2/ef/b6e2ef894ef8e63a8a3e8c35a6e6144a.png',),
                SquareImageWidget(title: 'Adidas', image: 'https://i.pinimg.com/originals/b6/e2/ef/b6e2ef894ef8e63a8a3e8c35a6e6144a.png',),
                SquareImageWidget(title: 'Adidas', image: 'https://i.pinimg.com/originals/b6/e2/ef/b6e2ef894ef8e63a8a3e8c35a6e6144a.png',),
              ],
            ),
          ),
          SizedBox(height: 15,),
          CustomOutlineButton(
            height: 30,
            width: 160,
            onTap: (){Get.to(UserSearchPage());},
            label: 'View all offers',
            fontStyle: TextStyle(fontSize: 10, fontFamily: 'open', fontWeight: FontWeight.w600, color: AppConst.black),
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: DefaultTabController(length: 2, child: TabBar(
              indicatorColor: AppConst.themePurple,
              labelStyle: AppConst.header2,
              tabs: [
                Tab(text: 'My favourite'),
                Tab(text: 'Near me',),
              ],
            )),
          ),
          SizedBox(height: 15,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('All restaurants near you', style: AppConst.header2,),
                Row(
                  children: [
                    Text('Sort by', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'open', color: AppConst.black),),
                    SizedBox(width: 5,),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 18,
                      elevation: 0,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, fontFamily: 'open', color: AppConst.black),
                      onChanged: (v) {
                        setState(() {
                          dropdownValue = v;
                        });
                      },
                      items: <String>['One', 'Two']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        if(index==0)Divider(height: 40, color: Color(0xff252525).withOpacity(0.4),),
                        StoreShopNowTile2(label: 'Something',),
                        Divider(height: 40, color: Color(0xff252525).withOpacity(0.4)),
                      ],
                    ),
                  );
            }),
          )
        ],
      ),
    );
  }
}
