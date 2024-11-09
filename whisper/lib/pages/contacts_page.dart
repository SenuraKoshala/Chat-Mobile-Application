import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  // List of all contacts
  final List<Contact> allContacts = [
    Contact(name: 'John Doe', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'Jane Smith', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'Alice Johnson', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'Bob Wilson', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'Mary Williams', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'David Brown', imageUrl: 'https://via.placeholder.com/150'),
    // Add more contacts as needed
  ];

  // List of filtered contacts
  List<Contact> filteredContacts = [];

  // Search query
  String query = '';

  @override
  void initState() {
    super.initState();
    filteredContacts = allContacts;
  }

  // Function to filter contacts based on search query
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
          // Styled Header Box
          Container(
            color: Colors.grey[100], // Light ash color
            child: SafeArea(
              child: Column(
                children: [
                  // AppBar with Search functionality
                  AppBar(
                    backgroundColor: Colors.grey[100],
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: TextField(
                      onChanged: _filterContacts, // Trigger search
                      decoration: const InputDecoration(
                        hintText: 'Search Contacts...',
                        hintStyle: TextStyle(color: Colors.black87),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(0),
                      ),
                      style: const TextStyle(color: Colors.black87),
                    ),
                    actions: const [
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.black87),
                        onPressed: null, // Search is handled by TextField
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Separate Section for "New Contact" and "New Group"
          Container(
            color: Colors.grey[200], // Slightly darker grey for distinction
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                    // Handle new contact
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

          // Contacts list (filtered based on search query)
          Expanded(
            child: ListView(
              children: filteredContacts.isNotEmpty
                  ? filteredContacts
                      .map(
                        (contact) => ContactListItem(
                          name: contact.name,
                          imageUrl: contact.imageUrl,
                        ),
                      )
                      .toList()
                  : [
                      const Center(
                        child: Text('No contacts found'),
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }
}

// Contact class to store contact information
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/default_avatar.png'),
        child: Text(name[0]), // Shows first letter if image fails to load
      ),
      title: Text(
        name,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: () {
        // Handle contact selection
      },
    );
  }
}
