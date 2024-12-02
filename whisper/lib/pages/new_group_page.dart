import 'package:flutter/material.dart';
import 'package:whisper/pages/contacts_page.dart';

// Import the Group and GroupManager
import 'group_list_view.dart';

class NewGroupPage extends StatefulWidget {
  const NewGroupPage({super.key});

  @override
  State<NewGroupPage> createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  final List<Contact> allContacts = [
    Contact(name: 'John Doe', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'Jane Smith', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'Alice Johnson', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'Bob Wilson', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'Mary Williams', imageUrl: 'https://via.placeholder.com/150'),
    Contact(name: 'David Brown', imageUrl: 'https://via.placeholder.com/150'),
  ];

  List<Contact> selectedContacts = [];
  final TextEditingController _groupNameController = TextEditingController();

  // Create an instance of GroupManager
  final GroupManager _groupManager = GroupManager();

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  void _toggleContactSelection(Contact contact) {
    setState(() {
      if (selectedContacts.contains(contact)) {
        selectedContacts.remove(contact);
      } else {
        selectedContacts.add(contact);
      }
    });
  }

  void _createGroup() {
    if (_groupNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a group name')),
      );
      return;
    }

    if (selectedContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one contact')),
      );
      return;
    }

    // Create a new Group
    final newGroup = Group(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
      name: _groupNameController.text,
      imageUrl: null, // No image path since picker is removed
      members: selectedContacts,
    );

    // Add the group to GroupManager
    _groupManager.addGroup(newGroup);

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Group "${newGroup.name}" created successfully')),
    );

    // Navigate back to previous screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Create New Group',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: _createGroup,
            child: const Text(
              'Create',
              style: TextStyle(color: Color(0xFF38B6FF)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Group Name Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _groupNameController,
              decoration: const InputDecoration(
                hintText: 'Group Name',
                border: UnderlineInputBorder(),
              ),
            ),
          ),

          // Contact Selection Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Select Contacts (${selectedContacts.length} selected)',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Contacts List
          Expanded(
            child: ListView.builder(
              itemCount: allContacts.length,
              itemBuilder: (context, index) {
                final contact = allContacts[index];
                final isSelected = selectedContacts.contains(contact);

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: const AssetImage('assets/default_avatar.png'),
                    child: Text(contact.name[0]),
                  ),
                  title: Text(contact.name),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (_) => _toggleContactSelection(contact),
                    activeColor: const Color(0xFF38B6FF),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
