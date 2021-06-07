import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:seeya/features/order_online/model/get_all_business_types.dart';
import 'package:seeya/main_app/config/gqlConfig.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/main_app/util/snack.dart';

class GetBusinessType {
  static getBusinessTypes() async {
    final businessTypeQuery = r'''
query{
  getAllBusinessTypes{
    error
    msg
    data{
      name
      _id
    }
  }
}
  ''';
    try {
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(businessTypeQuery),
        ),
      );

      bool loginError =
      result.data['getAllBusinessTypes']['error'];

      if (loginError) {
        Snack.top('Error',
            result.data['getAllBusinessTypes']['msg']);
      } else {
        return List<BusinessTypesData>.from(result
            .data['getAllBusinessTypes']['data']
            .map((type) =>
            BusinessTypesData.fromJson(type)));
      }
      return loginError;
    } catch (e) {
      print(e.toString());
      return true;
    }
  }
}
