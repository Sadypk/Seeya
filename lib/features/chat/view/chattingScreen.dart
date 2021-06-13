import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seeya/main_app/util/size_config.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChattingScreen extends StatelessWidget {
  final Channel channel;
  final GetSizeConfig sizeConfig = Get.find();

  ChattingScreen({Key key,@required this.channel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamChannel(
      channel: channel,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: ()=> Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white
            ),
          ),
          centerTitle: true,
          title: StreamBuilder<Map<String, dynamic>>(
            stream: channel.extraDataStream,
            initialData: channel.extraData,
            builder: (context, snapshot) {
              String title;
              if (snapshot.data['name'] == null &&
                  channel.state.members.length == 2) {
                final otherMember = channel.state.members
                    .firstWhere((member) => member.user.id != UserViewModel.user.value.id);
                title = otherMember.user.name;
              } else {
                title = snapshot.data['name'] ?? channel.id;
              }

              return Text(
                title.trim().capitalize,
                style: TextStyle(
                  color: Colors.white
                ),
              );
            },
          ),
          actions: [
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text(
                      'Clear chat'
                  ),
                ),
                PopupMenuItem(
                  child: Text(
                      'Block user'
                  ),
                ),
              ],
            ),
          ]
        ),
        body: Column(
          children: [
            Expanded(child: MessageListView()),
            MessageInput(
              disableAttachments: true,
            )
          ],
        ),
      ),
    );
  }
}
