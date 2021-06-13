import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:seeya/main_app/config/gqlConfig.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';

class ChangeAddressRepo {
  static changeAddress(String id) async {
    final _mutation = r'''
    mutation($id: ID){
  changeCustomerAddress(_id:$id){
    error
    msg
  }
}
''';

    try {
      final variables = {'id': id};

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client
          .query(QueryOptions(document: gql(_mutation), variables: variables));
      print(variables);
      print('change address error: ${result.data['changeCustomerAddress']['error']}');
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
