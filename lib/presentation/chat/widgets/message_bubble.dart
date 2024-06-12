import 'package:dchat/common/helper/formater_helper.dart';
import 'package:dchat/config/theme/fonts.dart';
import 'package:dchat/infrastructure/model/message_model.dart';
import 'package:dchat/presentation/rooms/rooms_controller.dart';
import 'package:dchat/widgets/image_viewer/circle_avatar.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
  });

  final MessageModel message;
  bool get isMyMessage => message.senderId == myUserId;
  DateTime get time => DateTime.parse(message.createdAt);

  @override
  Widget build(BuildContext context) {
    if (isMyMessage) {
      return myMessage();
    } else {
      return userMessage();
    }
  }

  Widget myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFE1F6DF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(2),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        width: 184,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(message.content),
            ),
            const SizedBox(height: 4),
            Text(
              replaceToFarsiNumber('${time.hour}:${time.minute}'),
              style: regular_11.copyWith(color: const Color(0xFF797C7B)),
            ),
          ],
        ),
      ),
    );
  }

  Widget userMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomCirculeAvatar(radius: 16),
          const SizedBox(width: 8),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF0F0F5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            width: 184,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(message.content),
                ),
                const SizedBox(height: 4),
                Text(
                  replaceToFarsiNumber('${time.hour}:${time.minute}'),
                  style: regular_11.copyWith(color: const Color(0xFF797C7B)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
