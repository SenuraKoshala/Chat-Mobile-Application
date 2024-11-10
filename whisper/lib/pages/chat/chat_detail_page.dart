// lib/pages/chat/chat_detail_page.dart
import 'package:flutter/material.dart';
import 'package:whisper/pages/chat/chat_messages.dart';
import 'message_input.dart';

class ChatDetailPage extends StatelessWidget {
  final Map<String, dynamic> chatData;

  const ChatDetailPage({
    super.key,
    required this.chatData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(chatData['image']),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Text(chatData['name']),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: ChatMessages(),
          ),
          const MessageInput(),
        ],
      ),
    );
  }
}