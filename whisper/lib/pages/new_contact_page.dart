import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewContactPage extends StatefulWidget {
  const NewContactPage({super.key});

  @override
  _NewContactPageState createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to add contact to Firestore
  Future<void> _saveContact() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      // Get the current user
      final user = _auth.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in')),
        );
        return;
      }

      // Prepare the contact data
      final contactData = {
        'name': _nameController.text,
        'mobile': _mobileController.text,
        'created_at': FieldValue.serverTimestamp(),
      };

      // Save to Firestore under the user's contacts subcollection
      await _firestore
          .collection('users')
          .doc(user.uid) // Use the logged-in user's ID
          .collection('contacts')
          .add(contactData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contact saved successfully')),
      );

      // Clear the form or navigate back
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving contact: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'New Contact',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Form in a white box with shadow
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name Field
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter the name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }

                        if (value.length < 3) {
                          return 'Name must have atleast 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Mobile Number Field
                    TextFormField(
                      controller: _mobileController,
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                        hintText: 'Enter mobile number',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        if (value.length != 10) {
                          return "Please enter a valid phone number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle form submission
                          _saveContact();
                          // Go back to the previous screen
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save Contact'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
