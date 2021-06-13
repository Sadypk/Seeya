import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:seeya/main_app/config/gqlConfig.dart';
import 'package:seeya/main_app/models/productModel.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';

class GetStoreProducts{
  static getStoreProducts(String id) async{
    final _query = r'''query($storeId: ID){
  getOrderOnlinePageProductsData(store: $storeId){
    error
    msg
    data{
      products{
        _id
        name
        logo
        catalog{
          name
          _id
          img
        }
        mrp
        selling_price
        cashback
        cashback_percentage
        details
        status
      }
      wallet_amount
    }
  }
}''';

    try{

      final variables = {
        'storeId': id
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));

      if(!result.data['getOrderOnlinePageProductsData']['error']){
        return ProductData.fromJson(result.data['getOrderOnlinePageProductsData']['data']);
      }else{
        return null;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}