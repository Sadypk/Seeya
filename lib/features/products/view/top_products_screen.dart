import 'package:flutter/material.dart';
import 'package:seeya/features/home_screen/view_models/top_products_view_model.dart';
import 'package:seeya/features/store/view/widgets/product_card_widget.dart';

class TopProductsScreen extends StatefulWidget {
  @override
  _TopProductsScreenState createState() => _TopProductsScreenState();
}

class _TopProductsScreenState extends State<TopProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Products'),
        backgroundColor: Colors.green,
      ),
    );
  }

  var forYouProducts = Container(
    height: 300,
    child: Column(
      children: [
        Text('For you', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index){
            var productList1 = TopProductsViewModel().productList;
            return ProductCardWidget(productModel: productList1[index],);
          }
        )
      ],
    ),
  );
}
