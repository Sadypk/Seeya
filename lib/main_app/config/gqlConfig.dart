
import 'package:graphql_flutter/graphql_flutter.dart';

class GqlConfig{

  static getClient([String token]){
    HttpLink link = HttpLink(
      // 'http://10.0.2.2:3000/graphql',
      'http://13.234.115.133:3000/graphql',
      defaultHeaders: <String, String>{
        'Authorization': 'Authorization $token',
      },
    );
    GraphQLClient cc = GraphQLClient(link: link, cache: GraphQLCache());
    return cc;
  }


  static getSocket (){
    WebSocketLink link = WebSocketLink(
      // 'ws://10.0.2.2:3000/graphql',
     'ws://13.234.115.133:3000/graphql',
    );
    GraphQLClient cc = GraphQLClient(link: link, cache: GraphQLCache());
    return cc;
  }
}