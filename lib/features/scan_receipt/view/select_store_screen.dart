import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/features/home_screen/view_models/nearest_store_view_model.dart';
import 'package:seeya/features/scan_receipt/view/scan_reciept_screen.dart';
import 'package:seeya/features/store/view/widgets/store_tile_widget.dart';
import 'package:seeya/main_app/resources/string_resources.dart';
import 'package:seeya/main_app/util/size_config.dart';

class SelectStoreScreen extends StatefulWidget {
  @override
  _SelectStoreScreenState createState() => _SelectStoreScreenState();
}

class _SelectStoreScreenState extends State<SelectStoreScreen> {
  //Widget size configuration
  GetSizeConfig getSizeConfig = Get.find();
  h(double v){return getSizeConfig.height.value*v;}
  w(double v){return getSizeConfig.width.value*v;}


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var searchBox = Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
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
          SizedBox(width: 10,),
          Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    hintText: 'Search',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)
                ),
              )
          ),
          SizedBox(width: 5,),
          Icon(Icons.search, size: 20, color: Colors.grey,),
          SizedBox(width: 10,),
        ],
      ),
    );

    var storeList = NearestStoreViewModel().storeList;

    return Scaffold(
      appBar: AppBar(
        title: Text("Virat Nagar", style: TextStyle(color: Colors.black),),
        actions: [
          TextButton(onPressed: (){
            // Get.to(PurchasedProductsScreen());
            Get.to(()=>ScanReceiptScreen());
          }, child: Text(StringResources.skipButtonText))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchBox,
            Divider(height: 25,),
             Text('Earn wherever you go!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            SizedBox(height: 5,),
            Text('Just add your bill!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
            SizedBox(height: 10,),
            Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index){
                    return StoreTileWidget(storeModel: storeList[index], onTap: (){Get.to(ScanReceiptScreen(storeModel: storeList[index],));},);
                  },
                  itemCount: storeList.length,
                )
            )
          ],
        ),
      ),
    );
  }
}
