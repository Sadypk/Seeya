import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:seeya/main_app/models/userModel.dart';
import 'package:seeya/main_app/resources/gqlConfig.dart';
import 'package:seeya/main_app/util/snack.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/features/chat/repository/streachatConfig.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class AuthRepo{

  static const mutationAuth = r'''
  mutation($mobile: String){
    customerLoginOrSignUp(mobile: $mobile){
      error
      msg
      token
      data{
        _id
        first_name
        last_name
        mobile
        email
        addresses{
          address
          location{
            lat
            lng
          }
        }
        balance
        logo
        date_of_birth
        male_or_female
      }
    }
  }
  ''';

  static requestLogin(String mobile) async{

    try{

      GraphQLClient client = GqlConfig.getClient();
      QueryResult result = await client.mutate(MutationOptions(
        document: gql(mutationAuth),
        variables: {
          'mobile' : '88'+mobile
        }
      ));

      bool loginError = result.data['customerLoginOrSignUp']['error'];

      if(loginError){
        Snack.top('Error', result.data['customerLoginOrSignUp']['msg']);
      }else{
        UserViewModel.setToken(result.data['customerLoginOrSignUp']['token']);
        UserViewModel.setUser(UserModel.fromJson(result.data['customerLoginOrSignUp']['data']));
        UserViewModel.changeUserStatus(UserStatus.LOGGED_IN);
        await SConfig.client.setUser(
            User(
              id: UserViewModel.user.value.id,
              extraData: {
                'name' : UserViewModel.user.value.firstName == '' && ' ' + UserViewModel.user.value.lastName == '' ? 'No Name' : UserViewModel.user.value.firstName + ' '+ UserViewModel.user.value.lastName,
                'image' : UserViewModel.user.value.logo == null || UserViewModel.user.value.logo == '' ? 'https://bellfund.ca/wp-content/uploads/2018/03/demo-user.jpg' : UserViewModel.user.value.logo,
                'userType' : 'customer'
              }
            ),
            SConfig.client.devToken(UserViewModel.user.value.id)
        );
        /// also need to update info if there is any
        /// otherwise setUser will only set according to id,
        /// it wont replace any info
        await SConfig.client.updateUser(
            User(
              id: UserViewModel.user.value.id,
              extraData: {
                'name' : UserViewModel.user.value.firstName == '' && ' ' + UserViewModel.user.value.lastName == '' ? 'No Name' : UserViewModel.user.value.firstName + ' '+ UserViewModel.user.value.lastName,
                'image' : UserViewModel.user.value.logo == null || UserViewModel.user.value.logo == '' ? 'https://bellfund.ca/wp-content/uploads/2018/03/demo-user.jpg' : UserViewModel.user.value.logo,
                'userType' : 'customer'
              }
            )
        );
      }
      return loginError;
    }catch(e){
      print(e.toString());
      return true;
    }

  }

}