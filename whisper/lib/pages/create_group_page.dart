import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupCreatePage extends StatefulWidget {
  const GroupCreatePage({super.key});

  @override
  _GroupCreatePageState createState() => _GroupCreatePageState();
}

class _GroupCreatePageState extends State<GroupCreatePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> _selectedContacts = [];
  List<Map<String, dynamic>> _contacts = [];  // To store all contacts

  final TextEditingController _groupNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  // Fetch contacts from Firestore (you can adjust this to match your contact data structure)
  Future<void> _fetchContacts() async {
    try {
      final currentUserId = _auth.currentUser!.uid;
      final contactsSnapshot = await _firestore
          .collection('contacts')
          .where('userId', isEqualTo: currentUserId)
          .get();

      setState(() {
        _contacts = contactsSnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'],
            'image': doc['image'],  // Assuming contacts have 'name' and 'image' fields
          };
        }).toList();
      });
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }

  // Create the group
  Future<void> _createGroup() async {
    final groupName = _groupNameController.text;
    if (groupName.isEmpty || _selectedContacts.isEmpty) {
      // Show error if the group name is empty or no contacts are selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a group name and select contacts')),
      );
      return;
    }

    try {
      final currentUserId = _auth.currentUser!.uid;
      final groupRef = await _firestore.collection('groups').add({
        'name': groupName,
        'createdBy': currentUserId,
        'members': [_auth.currentUser!.uid, ..._selectedContacts],
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Group created successfully!')),
      );

      // After creating the group, navigate to the new group page or group list
      Navigator.pop(context);  // Navigate back to the previous page
    } catch (e) {
      print('Error creating group: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error creating group')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _groupNameController,
              decoration: const InputDecoration(
                labelText: 'Group Name',
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return CheckboxListTile(
                    value: _selectedContacts.contains(contact['id']),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _selectedContacts.add(contact['id']);
                        } else {
                          _selectedContacts.remove(contact['id']);
                        }
                      });
                    },
                    title: Text(contact['name']),
                    secondary: CircleAvatar(
                      backgroundImage: NetworkImage(contact['image']),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _createGroup,
              child: const Text('Create Group'),
            ),
          ],
        ),
      ),
    );
  }
}
