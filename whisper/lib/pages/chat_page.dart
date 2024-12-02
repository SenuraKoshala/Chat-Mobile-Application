import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whisper/pages/chat/chat_header.dart'; // Import the new ChatHeader
import 'package:whisper/pages/widgets/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  final String contactId;
  final String contactName;

  const ChatPage({
    super.key,
    required this.contactId,
    required this.contactName,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ScrollController _scrollController = ScrollController();

  Stream<QuerySnapshot> _getChatMessages() {
    String currentUserId = _auth.currentUser!.uid;
    String chatId = _generateChatId(currentUserId, widget.contactId);

    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  String _generateChatId(String userId1, String userId2) {
    return userId1.compareTo(userId2) < 0
        ? '$userId1-$userId2'
        : '$userId2-$userId1';
  }

  void _sendMessage() async {
    String message = _messageController.text.trim();
    if (message.isEmpty) return;

    String currentUserId = _auth.currentUser!.uid;
    String chatId = _generateChatId(currentUserId, widget.contactId);

    await _firestore.collection('chats').doc(chatId).collection('messages').add({
      'sender': currentUserId,
      'recipient': widget.contactId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();
    
    // Scroll to bottom after sending message
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Prepare chat data for the header
    Map<String, dynamic> chatData = {
      'id': widget.contactId,
      'name': widget.contactName,
    };

    return Scaffold(
      appBar: ChatHeader(chatData: chatData), // Replace default AppBar with ChatHeader
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _getChatMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    bool isCurrentUser = message['sender'] == _auth.currentUser!.uid;

                    return ChatBubble(
                      message: message['message'],
                      isSentByMe: isCurrentUser,
                      timestamp: (message['timestamp'] as Timestamp).toDate(),
                      senderName: !isCurrentUser ? widget.contactName : null,
                    );
                  },
                );
              },
            ),
          ),
          // Message input area
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
