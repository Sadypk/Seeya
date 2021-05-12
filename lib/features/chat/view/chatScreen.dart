import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';

import '../model/ddModel.dart';
import 'widgets/chatTileWidget.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DDModel selectedOption = DDModel.items[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        actions: [
          TextButton(
            onPressed: (){},
            child: Text(
              'Edit',
              style: TextStyle(
                  color: Colors.grey
              ),
            )
          )
        ],
        bottom: AppBar(
          leadingWidth: Get.width * .8,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: selectedOption,
                onChanged: (value){
                  setState(() {
                    selectedOption = value;
                  });
                },
                items: DDModel.items.map((DDModel item) => DropdownMenuItem(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  value: item,
                )).toList(),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ChannelsBloc(
          child: ChannelListView(
            pagination: PaginationParams(limit: 20),

            /// making sure the chats only the user is in is shown
            // filter: {
            //   'members': {
            //     '\$in': [UserViewModel.user.value.id]
            //   }
            // },
            /// when there is no chat builds this
            emptyBuilder: (_)=> Center(
              child: Text(
                  'You have no chats, start a chat with a store'
              ),
            ),
            /// custom channel preview
            channelPreviewBuilder: (_, channel) => ChatTileWidget(channel: channel),
            sort: [SortOption('last_message_at')],
          ),
        ),
      ),
    );
  }
}
