import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/main_app/config/gqlConfig.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'newDataViewModel.dart';
import 'package:seeya/features/home_screen/models/homeFavStoreModel.dart';

class NewApi{
  static var logger = Logger();

  static Future<void> getAllCategories() async{
    final _query = r'''query{
     getAllBusinessTypes{
      error
      data{
        _id
        name
        }
      }
    }''';

    try{
     GraphQLClient client = GqlConfig.getClient();
      QueryResult result = await client.query(QueryOptions(document: gql(_query)));
      logger.i(result.data);
      if(!result.data['getAllBusinessTypes']['error']){
        NewDataViewModel.businessTypes = List.from(result.data['getAllBusinessTypes']['data'].map((type)=>BusinessType.fromJson(type)));
      }
    }catch(e){
      print(e.toString());
    }
  }

  static Future<void> getHomeFavShops() async{
    final _query = r'''query($lat : Float $lng: Float){
    getHomePageFavoriteShops(lat: $lat, lng:$lng){
      error
      msg
      data{
        _id
        name
        logo
        default_cashback
      }
    }
  }''';

    try{

      //TODO static for now
      final variables = {
        'lat' : 22.8259896,
        'lng' : 89.5510924,
      };

     GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));
      logger.i(result.data);
      if(!result.data['getHomePageFavoriteShops']['error']){
        NewDataViewModel.homeFavStores = List.from(result.data['getHomePageFavoriteShops']['data'].map((type)=>HomeFavModel.fromJson(type)));
      }
    }catch(e){
      print(e.toString());
    }
  }

  static Future<void> getHomePageSpecialOfferAndCategoryData(String bType, [int pSize, int pNum]) async{
    final _query = r'''query($lat: Float $lng: Float $bType: ID $pSize: Int $pNum: Int){
  getHomePageSpecialOfferAndCategoryData(
    lat: $lat
    lng: $lng
    businesstype: $bType
    page_size: $pSize
    page_number: $pNum
  ){
    error
    msg
    data{
      products{
        _id
        name
        store{
          _id
        }
        cashback
        selling_price
        expiry_date
      }
      stores{
        _id
        name
        promotion_cashback_status
        promotion_cashback
        default_cashback
        promotion_cashback_date{
          start_date
          end_date
        }
      }
    }
  }
}''';

    try{

      //TODO static for now
      final variables = {
        "lat": 22.8259892,
        "lng": 89.5510924,
        "bType": "",
        "pSize": pSize ?? 100,
        "pNum": pNum ?? 1
      };

     GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));
      logger.i(result.data);
      if(!result.data['getHomePageSpecialOfferAndCategoryData']['error']){
        NewDataViewModel.homeFavStores = List.from(result.data['getHomePageSpecialOfferAndCategoryData']['data'].map((type)=>HomeFavModel.fromJson(type)));
      }
    }catch(e){
      print(e.toString());
    }
  }
}