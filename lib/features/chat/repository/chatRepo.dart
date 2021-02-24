import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'streachatConfig.dart';

class ChatRepo{
  static Future<Channel> createChat(String userId) async{
    final channel = SConfig.client.channel(
        'messaging',
        id: UserViewModel.user.value.id + userId,
        extraData: {
          'members' : [
            UserViewModel.user.value.id,
            userId
          ]
        }
    );


    await channel.create();

    await channel.watch();

    return channel;
  }
}