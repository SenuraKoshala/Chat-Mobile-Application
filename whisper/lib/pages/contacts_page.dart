import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whisper/pages/new_contact_page.dart';
import 'package:whisper/pages/chat_page.dart'; // Import the chat page

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final List<Contact> allContacts = [];
  List<Contact> filteredContacts = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    _fetchContacts(); // Fetch contacts when the widget initializes
  }

  Future<void> _fetchContacts() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      // Fetch contacts from Firebase Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('contacts')
          .get();

      final fetchedContacts = snapshot.docs.map((doc) {
        return Contact(
          id: doc.id,
          name: doc['name'],
        );
      }).toList();

      // Update state to display the contacts
      setState(() {
        allContacts.addAll(fetchedContacts);
        filteredContacts = allContacts;
      });
    } catch (e) {
      // Handle errors (e.g., network issues)
      print('Failed to fetch contacts: $e');
    }
  }

  void _filterContacts(String query) {
    setState(() {
      this.query = query;
      filteredContacts = allContacts
          .where((contact) =>
              contact.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // AppBar with search
          Container(
            color: Colors.grey[100],
            child: SafeArea(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.grey[100],
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: TextField(
                      onChanged: _filterContacts,
                      decoration: const InputDecoration(
                        hintText: 'Search Contacts...',
                        hintStyle: TextStyle(color: Colors.black87),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(0),
                      ),
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
          ),
// "New Contact" section from previous implementation
          Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF38B6FF),
                    child: Icon(Icons.person_add, color: Colors.white),
                  ),
                  title: const Text(
                    'New Contact',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    // Navigate to the New Contact page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewContactPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF38B6FF),
                    child: Icon(Icons.group_add, color: Colors.white),
                  ),
                  title: const Text(
                    'New Group',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    // Handle new group
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const NewGroupPage()),
                    // );
                  },
                ),
              ],
            ),
          ),

          // "All Contacts" heading
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            alignment: Alignment.centerLeft,
            child: const Text(
              'All Contacts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: filteredContacts
                  .map((contact) => ContactListItem(
                        name: contact.name,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                contactId: contact.id,
                                contactName: contact.name,
                              ),
                            ),
                          );
                        },
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class Contact {
  final String id;
  final String name;

  Contact({required this.id, required this.name});
}

class ContactListItem extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;

  const ContactListItem({
    super.key,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(name[0]),
      ),
      title: Text(name),
      onTap: onTap,
    );
  }
}