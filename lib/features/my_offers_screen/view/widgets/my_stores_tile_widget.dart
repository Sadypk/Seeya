import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seeya/features/chat/repository/chatRepo.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/home.dart';

class MyStoreTileWidget extends StatelessWidget {
  final StoreModel store;

  const MyStoreTileWidget({Key key,@required this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        /// not yet final if this will start the chat but am just doing this for testing -taz

        ///creating channel / chat room
        Home.changeLoading();
        await ChatRepo.createChat(store.id);
        Home.changeLoading();
      },
      child: Container(
        height: 80,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[100]),
          boxShadow: [
            BoxShadow(
                offset: Offset(1,1),
                color: Colors.grey[500],
                spreadRadius: 1,
                blurRadius: 1
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[500]),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:
                  Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                  colors: [
                    Colors.black45,
                    Colors.black26
                  ], // red to yellow
                ),
              ),
              child: Center(
                child: Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(store.logo),
                      // fit: BoxFit.cover
                    ),
                  ),

                ),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(store.name, style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 3,),
                Text('Some Description Text', style: TextStyle(fontSize: 10),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
