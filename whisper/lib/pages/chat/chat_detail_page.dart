// lib/pages/chat/chat_detail_page.dart
import 'package:flutter/material.dart';
import 'message_input.dart';
import 'chat_messages.dart';
import 'chat_header.dart';

class ChatDetailPage extends StatelessWidget {
  final Map<String, dynamic> chatData;

  const ChatDetailPage({
    super.key,
    required this.chatData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatHeader(chatData: chatData),
      body: const Column(
        children: [
          Expanded(
            child: ChatMessages(),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}