import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/order_online/view/store_view.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/newMainAPIs.dart';

class SearchStore extends StatefulWidget {
  final List<StoreData> allStores;

  SearchStore({@required this.allStores});

  @override
  _SearchStoreState createState() => _SearchStoreState();
}

class _SearchStoreState extends State<SearchStore> {
  TextEditingController searchController = TextEditingController();
  List<StoreData> searchResult = [];
  bool matchFound = false;

  @override
  void initState() {
    super.initState();
    onSearchTextChanged('');
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      widget.allStores.forEach((element) {
        setState(() {
          searchResult.add(element);
          matchFound = false;
        });
      });
      return;
    }

    widget.allStores.forEach((element) {
      if (element.name.toLowerCase().contains(text.toLowerCase())) {
        setState(() {
          searchResult.add(element);
          matchFound = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Search Store',
          style: AppConst.appbarTextStyle,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        primary: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border:
                        Border.all(color: Color(0xff252525).withOpacity(0.4)),
                    color: Colors.white),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: Icon(
                          Icons.search,
                          color: AppConst.black.withOpacity(0.7),
                        )),
                    Flexible(
                        child: TextFormField(
                      controller: searchController,
                      onChanged: onSearchTextChanged,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Enter any store name here',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'open',
                          color: AppConst.black.withOpacity(0.7),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Trending near your',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
              ListView.builder(
                  padding: EdgeInsets.only(bottom: 20),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: searchResult.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => StoreView(storeData: searchResult[index]));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                searchResult[index].logo,
                                              )
                                          )
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          searchResult[index].name,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Store type: ${searchResult[index].store_type}',
                                          style: TextStyle(fontSize: 12,color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Cashback: ${searchResult[index].defaultCashbackOffer.toString()}%',
                                          style: TextStyle(fontSize: 12,color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  'Visit',
                                  style: TextStyle(fontSize: 12,color: AppConst.themePurple),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
