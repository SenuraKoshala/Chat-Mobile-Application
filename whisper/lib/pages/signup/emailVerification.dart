import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whisper/pages/signup/signup.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
        leading: BackButton(
          onPressed: () async {
            User? user = FirebaseAuth.instance.currentUser;

            if (user != null && !user.emailVerified) {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .delete();

              await user.delete(); // Deletes the user
            }
            Navigator.pop(context); // Default back navigation
          },
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null && !user.emailVerified) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUp()),
              );
            }
          },
          child: const Text("Next"),
        ),
      ),
    );
  }
}
