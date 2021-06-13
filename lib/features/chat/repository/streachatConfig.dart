import 'package:dio/dio.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SConfig{
  static final client = StreamChatClient(
      'ahpubb5rvjub',
      logLevel: Level.WARNING
  );

  static final Dio dio = new Dio()..options = BaseOptions(
      headers: {
        'Accept-Version' : 'v1',
        'Authorization' : 'Client-ID hjk9yn2vbekesycxv6wz6vwzcr6d92598s7p2ae53jfzcpqh8etyj4kqrpmpjkv5'
      }
  );


  static Future<Channel> createChat(String id) async{
    try{
      final channel = client.channel(
          'messaging',
          id: UserViewModel.user.value.id + id,
          extraData: {
            'members' : [
              UserViewModel.user.value.id,
              id
            ]
          }
      );


      await channel.create();

      await channel.watch();

      return channel;
    }catch(e){
      return null;
    }
  }
}