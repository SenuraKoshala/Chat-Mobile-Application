import 'package:flutter/material.dart';
import 'package:whisper/pages/contacts_page.dart'; // Import Contact model

class Group {
  String id; // Unique identifier for the group
  String name;
  String? imageUrl; // Optional group image
  List<Contact> members;

  Group({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.members,
  });
}

class GroupListView extends StatefulWidget {
  const GroupListView({super.key});

  @override
  _GroupListViewState createState() => _GroupListViewState();
}

class _GroupListViewState extends State<GroupListView> {
  // Singleton-like approach to manage groups across the app
  static final GroupManager _groupManager = GroupManager();

  @override
  Widget build(BuildContext context) {
    return _groupManager.groups.isEmpty
        ? const Center(
            child: Text(
              'No groups yet\nCreate a new group to get started',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          )
        : ListView.builder(
            itemCount: _groupManager.groups.length,
            itemBuilder: (context, index) {
              final group = _groupManager.groups[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  backgroundImage: group.imageUrl != null
                      ? NetworkImage(group.imageUrl!)
                      : null,
                  child: group.imageUrl == null
                      ? Text(
                          group.name[0].toUpperCase(),
                          style: const TextStyle(color: Colors.blue),
                        )
                      : null,
                ),
                title: Text(group.name),
                subtitle: Text('${group.members.length} members'),
                onTap: () {
                  // TODO: Implement group chat/details view
                },
              );
            },
          );
  }
}

// Singleton-like class to manage groups across the app
class GroupManager {
  static final GroupManager _instance = GroupManager._internal();
  factory GroupManager() => _instance;

  GroupManager._internal();

  final List<Group> _groups = [];

  List<Group> get groups => List.unmodifiable(_groups);

  void addGroup(Group group) {
    _groups.add(group);
  }

  // Optional: method to remove a group
  void removeGroup(String groupId) {
    _groups.removeWhere((group) => group.id == groupId);
  }
}