import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:seeya/main_app/config/gqlConfig.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/main_app/util/imagePicker.dart';
import 'package:seeya/newMainAPIs.dart';

class ConfirmOrderRepo{
  static Future<bool> placeOrder({List<File> images, BoomModel store,var rawItem, var products, double total, String order_type, int wallet_amount}) async{
    final mutation = r'''
       mutation(
      $image: String 
      $storeId: ID 
      $products: [OrderProduct] 
      $raw_items: [OrderRawDataInput] 
      $total: Float 
      $cashback: Float 
      $lat: Float 
      $lng: Float 
      $order_type: String 
      $address: String
      $wallet_amount: Float){
      placeOrder(orderInput:{
        order_type: $order_type
        receipt: $image
        store: $storeId
        products: $products
        raw_items: $raw_items
        total: $total
        cashback_percentage: $cashback
        wallet_amount: $wallet_amount
        address: $address
        lat: $lat
        lng: $lng
      }){
        error
        msg
      }
    }
    ''';

    try{

      List<String> imageLinks = [];
      if(images != null){
        for (File image in images) {
          imageLinks.add(await ImageHelper.uploadImage(image));
        }
      }else{
        imageLinks.add('');
      }


      double cashBack = store.defaultCashbackOffer.toDouble();
      final today = DateTime.now();
      if(store.promotionCashbackOfferStatus == 'active' && store.promotionCashbackOfferDate.startDate.isBefore(today) && store.promotionCashbackOfferDate.endDate.isAfter(today)){
        cashBack = store.promotionCashbackOffer.toDouble();
      }

      // TODO sending only one image

      final variables = {
        'order_type' : 'online',
        'image' : imageLinks[0],
        'products' : List.from(products.map((e) => e.toJson())),
        'raw_items' : List.from(rawItem.map((e) => e.toJson())),
        'storeId' : store.id,
        'total' : total,
        'cashback' : cashBack,
        'wallet_amount': wallet_amount,
        'address': UserViewModel.user.value.addresses[UserViewModel.locationIndex.value].address,
        'lat': UserViewModel.user.value.addresses[UserViewModel.locationIndex.value].location.lat,
        'lng': UserViewModel.user.value.addresses[UserViewModel.locationIndex.value].location.lng,
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(mutation),variables: variables));

      print(variables);

      return result.data['placeOrder']['error'];
    }catch(e){
      print(e.toString());
      return true;
    }
  }
}