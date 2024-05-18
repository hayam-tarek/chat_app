import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubbleLeft extends StatelessWidget {
  const ChatBubbleLeft({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IntrinsicWidth(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: kSecondColor,
          ),
          child: Row(
            children: [
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Text(
              //       'hayam:',
              //       style: TextStyle(
              //         fontSize: 12,
              //         color: Colors.black54,
              //       ),
              //     ),
              //   ],
              // ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    maxLines: 500,
                    overflow: TextOverflow.ellipsis,
                    message.message,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${message.time.hour}:${message.time.minute}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
