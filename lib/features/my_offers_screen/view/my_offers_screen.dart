import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:seeya/features/my_offers_screen/repository/repo.dart';
import 'package:seeya/features/my_offers_screen/view/widgets/my_stores_tile_widget.dart';
import 'package:seeya/features/store/models/storeModel.dart';

class MyOffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Text('Refer and Earn', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.lightBlueAccent,
                    ),
                    child: Center(child: Text('Refer a friend and earn', textAlign: TextAlign.center,)),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: 120,
                    width: 120,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orangeAccent,
                    ),
                    child: Center(child: Text('Refer a store and earn', textAlign: TextAlign.center,)),
                  )
                ],
              ),
              SizedBox(height: 30,),
              Text('My Stores', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Divider(height: 20,thickness: 2, color: Colors.black,),
              FutureBuilder(
                future: MyOfferStoresRepo.getRestaurants(),
                builder: (_, AsyncSnapshot<List<StoreModel>>snapshot){
                  if(snapshot.hasData && snapshot.data != null){
                    if(snapshot.data == null){
                      return Text('something went wrong');
                    }else if(snapshot.data.length == 0){
                      return Text('no store found');
                    }else{
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) => MyStoreTileWidget(store: snapshot.data[index],)
                        )
                      );
                    }
                  }else{
                    return SpinKitWave(color: Theme.of(context).primaryColor);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
