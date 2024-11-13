import 'package:flutter/material.dart';
import 'package:whisper/pages/new_contact_page.dart'; // Import the new contact page

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final List<Contact> allContacts = [
    Contact(name: 'John Doe', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'Jane Smith', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'Alice Johnson', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'Bob Wilson', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'Mary Williams', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'David Brown', imageUrl: 'https://via.placeholder.com/150'),
    // Add more contacts as needed
  ];

  List<Contact> filteredContacts = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    filteredContacts = allContacts;
  }

  void _filterContacts(String query) {
    setState(() {
      this.query = query;
      filteredContacts = allContacts
          .where((contact) => contact.name.toLowerCase().contains(query.toLowerCase()))
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
                      MaterialPageRoute(builder: (context) => const NewContactPage()),
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

          // List of filtered contacts
          Expanded(
            child: ListView(
              children: filteredContacts
                  .map((contact) => ContactListItem(
                        name: contact.name,
                        imageUrl: contact.imageUrl,
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
  final String name;
  final String imageUrl;

  Contact({required this.name, required this.imageUrl});
}

class ContactListItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  const ContactListItem({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: const AssetImage('assets/default_avatar.png'),
        child: Text(name[0]),
      ),
      title: Text(name),
    );
  }
}
