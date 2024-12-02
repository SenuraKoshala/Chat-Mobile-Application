import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whisper/pages/chat_page.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  _ChatListViewState createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<ChatInfo>> _getChatList() {
    String currentUserId = _auth.currentUser!.uid;

    return _firestore
        .collection('chats')
        .where('users', arrayContains: currentUserId)
        .snapshots()
        .asyncMap((snapshot) async {
          List<Future<ChatInfo>> chatInfoFutures = snapshot.docs.map((doc) async {
            // Extract the other user's ID from the chat
            List<String> users = List<String>.from(doc['users']);
            String otherUserId = users.firstWhere((id) => id != currentUserId);

            // Fetch the last message
            var lastMessageQuery = await _firestore
                .collection('chats')
                .doc(doc.id)
                .collection('messages')
                .orderBy('timestamp', descending: true)
                .limit(1)
                .get();

            String lastMessage = lastMessageQuery.docs.isNotEmpty 
                ? lastMessageQuery.docs.first['message'] 
                : '';

            // Fetch user data
            var userDoc = await _firestore.collection('users').doc(otherUserId).get();

            return ChatInfo(
              chatId: doc.id,
              userId: otherUserId,
              userName: userDoc['name'] ?? 'Unknown User',
              lastMessage: lastMessage,
              timestamp: lastMessageQuery.docs.isNotEmpty 
                  ? lastMessageQuery.docs.first['timestamp'] 
                  : null,
            );
          }).toList();

          return await Future.wait(chatInfoFutures);
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatInfo>>(
      stream: _getChatList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No chats yet\nStart a conversation!', 
              textAlign: TextAlign.center,
            ),
          );
        }

        final chats = snapshot.data!;

        // Sort chats by most recent message
        chats.sort((a, b) {
          if (a.timestamp == null) return 1;
          if (b.timestamp == null) return -1;
          return b.timestamp!.compareTo(a.timestamp!);
        });

        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(
                  chat.userName[0].toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                chat.userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                chat.lastMessage.isNotEmpty ? chat.lastMessage : 'No messages',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      contactId: chat.userId,
                      contactName: chat.userName,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class ChatInfo {
  final String chatId;
  final String userId;
  final String userName;
  final String lastMessage;
  final Timestamp? timestamp;

  ChatInfo({
    required this.chatId,
    required this.userId,
    required this.userName,
    required this.lastMessage,
    this.timestamp,
  });
}