import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble_left.dart';
import 'package:chat_app/widgets/chat_bubble_right.dart';
import 'package:chat_app/widgets/message_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static const String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: kFirstColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              scale: 10,
            ),
            const Text(
              ' Chat',
              style: TextStyle(
                fontFamily: 'Pacifico',
              ),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: messages.orderBy('time', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MessageModel> messagesList = [];
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        if (messagesList[index].id == email) {
                          return ChatBubbleRight(message: messagesList[index]);
                        } else {
                          return ChatBubbleLeft(
                            message: messagesList[index],
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 7.5,
                      horizontal: 10,
                    ),
                    child: MessageTextField(
                      controller: textEditingController,
                      onPressed: () async {
                        if (textEditingController.text.isNotEmpty) {
                          await messages.add({
                            'message': textEditingController.text,
                            'time': DateTime.now(),
                            'id': email
                          });
                        }
                        textEditingController.clear();
                        scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      onChanged: (value) {
                        textEditingController.text = value;
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('No messages'));
            }
          }),
    );
  }
}
