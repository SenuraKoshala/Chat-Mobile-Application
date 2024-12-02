import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  final DateTime timestamp;
  final String? senderName;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSentByMe,
    required this.timestamp,
    this.senderName,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          gradient: isSentByMe
            ? LinearGradient(
                colors: [
                  Color(0xFF6A11CB).withOpacity(0.9),
                  Color(0xFF2575FC).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [
                  Colors.grey.shade200,
                  Colors.grey.shade300,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isSentByMe 
              ? const Radius.circular(20) 
              : const Radius.circular(0),
            bottomRight: isSentByMe 
              ? const Radius.circular(0) 
              : const Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sender name for received messages
            if (!isSentByMe && senderName != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  senderName!,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            
            // Message text
            Text(
              message,
              style: TextStyle(
                color: isSentByMe ? Colors.white : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            
            // Timestamp
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  DateFormat('h:mm a').format(timestamp),
                  style: TextStyle(
                    color: isSentByMe 
                      ? Colors.white70 
                      : Colors.black54,
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}