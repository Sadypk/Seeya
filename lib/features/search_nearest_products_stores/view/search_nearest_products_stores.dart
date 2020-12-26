import 'package:flutter/material.dart';

class SearchNearestProductsStores extends StatefulWidget {
  @override
  _SearchNearestProductsStoresState createState() => _SearchNearestProductsStoresState();
}

class _SearchNearestProductsStoresState extends State<SearchNearestProductsStores> {
  @override
  Widget build(BuildContext context) {
    var customAppBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 40,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Text('Back'),
          ),
        ),
        Container(
          height: 40,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Text('Message'),
          ),
        )
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              customAppBar
            ],
          ),
        ),
      ),
    );
  }
}
