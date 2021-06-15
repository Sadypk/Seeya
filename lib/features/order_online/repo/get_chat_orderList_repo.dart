import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:seeya/features/order_online/model/get_chat_orderList.dart';
import 'package:seeya/main_app/config/gqlConfig.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/main_app/util/snack.dart';

class GetChatOrderListRepo{
  static getCharOrder(String id) async{
    final _query = r'''
    query($store:ID){
  getChatOrderAutocompleteData(store: $store){
    error
    msg
    data{
      _id
      name
    }
  }
}''';

    try{

      final variables = {
        // 'store': '60843ff9cc453f7be2e4471a'
        'store': id
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));

      bool loginError =
      result.data['getChatOrderAutocompleteData']['error'];
      if (loginError) {
        Snack.top('Error',
            result.data['getChatOrderAutocompleteData']['msg']);
      } else {
        return GetChatOrderAutocompleteData.fromJson(result.data['getChatOrderAutocompleteData']);
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}