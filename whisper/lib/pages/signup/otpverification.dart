import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whisper/pages/signup/signup.dart';

class Otpverification extends StatefulWidget {
  const Otpverification({super.key});

  @override
  State<Otpverification> createState() => _OtpverificationState();
}

class _OtpverificationState extends State<Otpverification> {
  late final phoneNumberController = TextEditingController();
  late final otpController = TextEditingController();
  String globalVerificationID = '';

  @override
  void dispose() {
    phoneNumberController.dispose();
    otpController.dispose();
    super.dispose();
  }

  final _globalKey = GlobalKey<FormState>();

  void _verifyOTP() async {
    String otp = otpController.text.trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: globalVerificationID,
      smsCode: otp,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("Phone verification successful.");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUp()),
      );
    } catch (e) {
      print("Failed to verify OTP: $e");
      // Show error dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Expanded(
                child: Form(
                  key: GlobalKey(),
                  child: TextFormField(
                    controller: phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      hintText: 'Enter your mobile number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      if (value.length != 12) {
                        return "Please enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_globalKey.currentState!.validate()) {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: phoneNumberController.text,
                        timeout: const Duration(seconds: 60),
                        verificationCompleted:
                            (PhoneAuthCredential credential) async {
                          // Auto-retrieval scenario (Android only)
                          await FirebaseAuth.instance
                              .signInWithCredential(credential);
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("OTP Verified"),
                                content: const Text(
                                    "Phone number automatically verified."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUp()),
                                      );
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          if (e.code == 'invalid-phone-number') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Invalid Phone Number"),
                                  content: const Text(
                                      "Phone number you entered is invalid. Check your phone number."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          globalVerificationID = verificationId;
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          // Auto-resolution timed out...
                        },
                      );
                    }
                  },
                  child: Text('Request OTP'))
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Form(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Verify OTP',
                      hintText: 'Enter OTP',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the OTP code';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              ElevatedButton(onPressed: _verifyOTP, child: Text('Verify'))
            ],
          ),
        ],
      ),
    );
  }
}
