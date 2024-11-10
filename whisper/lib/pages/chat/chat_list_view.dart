// lib/pages/chat/chat_list_view.dart
import 'package:flutter/material.dart';
import 'chat_item.dart';
import 'chat_detail_page.dart';
//import 'package:intl/intl.dart'; //need to have intl: ^0.18.0

class ChatListView extends StatelessWidget {
  final List<Map<String, dynamic>> chats = [
    {
      'name': 'John Doe',
      'lastMessage': 'Hey, how are you?',
      'time': DateTime.now().subtract(const Duration(minutes: 5)),
      'image': 'assets/default_avatar.png',
      'unread': 2,
    },
    {
      'name': 'Jane Smith',
      'lastMessage': 'See you tomorrow!',
      'time': DateTime.now().subtract(const Duration(hours: 1)),
      'image': 'assets/default_avatar.png',
      'unread': 0,
    },
  ];

  ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ChatItem(chat: chats[index]);
      },
    );
  }
}
