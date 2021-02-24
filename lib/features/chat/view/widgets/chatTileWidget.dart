import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/main_app/util/stringHelper.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../chattingScreen.dart';


class ChatTileWidget extends StatelessWidget {
  final Channel channel;
  ChatTileWidget({
    @required this.channel
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Get.to(ChattingScreen(channel: channel));
      },
      leading: StreamBuilder<Map<String, dynamic>>(                      /// chat from / channel name
        stream: channel.extraDataStream,
        initialData: channel.extraData,
        builder: (_, snapshot){
          String image;
          if (snapshot.data['image'] == null &&
              channel.state.members.length == 2) {
            final otherMember = channel.state.members
                .firstWhere((member) => member.user.id != UserViewModel.user.value.id);
            image = otherMember.user.extraData['image'];
            if(image.trim().length == 0){
              image = null;
            }
          } else {
            image = snapshot.data['name'] ?? channel.id;
            if(image.trim().length == 0){
              image = null;
            }
          }
          return CircleAvatar(
            child: image == null ? StreamBuilder<Map<String, dynamic>>(                      /// chat from / channel name
              stream: channel.extraDataStream,
              initialData: channel.extraData,
              builder: (_, snapshot){
                String name;
                if (snapshot.data['name'] == null &&
                    channel.state.members.length == 2) {
                  final otherMember = channel.state.members
                      .firstWhere((member) => member.user.id != UserViewModel.user.value.id);
                  name = otherMember.user.name;
                  if(name.trim().length == 0){
                    name = 'John Doe';
                  }
                } else {
                  name = snapshot.data['name'] ?? channel.id;
                  if(name.trim().length == 0){
                    name = 'John Doe';
                  }
                }
                return Text(
                  StringHelper.getInitials(name),
                  style: TextStyle(
                      letterSpacing: 4
                  ),
                );
              },
            ) : null,
            backgroundImage: image != null ? CachedNetworkImageProvider(
                image
            ) : null,
            radius: 25,
          );
        },
      ),
      title: StreamBuilder<Map<String, dynamic>>(                      /// chat from / channel name
        stream: channel.extraDataStream,
        initialData: channel.extraData,
        builder: (_, snapshot){
          String name;
          if (snapshot.data['name'] == null &&
              channel.state.members.length == 2) {
            final otherMember = channel.state.members
                .firstWhere((member) => member.user.id != UserViewModel.user.value.id);
            name = otherMember.user.name;
            if(name.trim().length == 0){
              name = 'John Doe';
            }
          } else {
            name = snapshot.data['name'] ?? channel.id;
            if(name.trim().length == 0){
              name = 'John Doe';
            }
          }
          return Text(
              name
          );
        },
      ),
      subtitle: StreamBuilder(                                       /// last message builder
        initialData: channel.state.unreadCount,
        stream: channel.state.unreadCountStream,
        builder: (context, snapshot) {
          return TypingIndicator(
            channel: channel,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey
            ),
            alternativeWidget: StreamBuilder<List<Message>>(
              stream: channel.state.messagesStream,
              initialData: channel.state.messages,
              builder: (context, snapshot) {
                final lastMessage = snapshot.data?.lastWhere(
                      (m) => m.shadowed != true,
                  orElse: () => null,
                );
                if (lastMessage == null) {
                  return Text(
                      'No Message'
                  );
                }

                var text = lastMessage.text;
                if (lastMessage.isDeleted) {
                  text = 'This message was deleted.';
                } else if (lastMessage.attachments != null) {
                  final prefix = lastMessage.attachments
                      .map((e) {
                    if (e.type == 'image') {
                      return '📷';
                    } else if (e.type == 'video') {
                      return '🎬';
                    } else if (e.type == 'giphy') {
                      return 'GIF';
                    }
                    return null;
                  })
                      .where((e) => e != null)
                      .join(' ');

                  text = '$prefix ${lastMessage.text ?? ''}';
                }

                return Text(
                    text,
                    maxLines: 4
                );
              },
            ),
          );
        },
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder<DateTime>(                                    /// last message time or chat time
            stream: channel.lastMessageAtStream,
            initialData: channel.lastMessageAt,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox();
              }
              final lastMessageAt = snapshot.data.toLocal();

              String stringDate;
              final now = DateTime.now();

              if (now.year != lastMessageAt.year ||
                  now.month != lastMessageAt.month ||
                  now.day != lastMessageAt.day) {
                stringDate = DateFormat('dd/MM/yyyy').format(lastMessageAt.toLocal());
              } else {
                stringDate = DateFormat().add_jm().format(lastMessageAt.toLocal());
              }

              return Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text(
                  stringDate,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey
                  ),
                ),
              );
            },
          ),
          StreamBuilder<int>(
              stream: channel.state.unreadCountStream,
              initialData: channel.state.unreadCount,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == 0) {
                  return SizedBox();
                }
                return UnseenMessageLabelWidget(count: snapshot.data);
              }
          )
        ],
      ),
    );
  }
}

class UnseenMessageLabelWidget extends StatelessWidget {
  final int count;
  UnseenMessageLabelWidget({
    this.count
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green
      ),
      padding: EdgeInsets.all(6),
      child: Text(
        '$count',
        style: TextStyle(
            color: Colors.white
        ),
      ),
    );
  }
}
