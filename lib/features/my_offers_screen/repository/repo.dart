import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/main_app/resources/gqlConfig.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';

class MyOfferStoresRepo{
  static const queryGetRestaurants = r'''
  query{
  getAllLinkedStoresByCustomer{
    error
    msg
    data{
      _id
      name
      businesstype{
        _id
        name
      }
    	address{
        address
        location{
          lat
          lng
        }
      }
      logo
      default_cashback
      default_welcome_offer
      promotion_cashback
      promotion_welcome_offer
    }
  }
}
  ''';

  static Future<List<StoreModel>> getRestaurants() async{

    try{
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(
          document: gql(queryGetRestaurants)
      ));
      return List<StoreModel>.from(result.data['getAllLinkedStoresByCustomer']['data'].map((x) => StoreModel.fromJson(x)));
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}