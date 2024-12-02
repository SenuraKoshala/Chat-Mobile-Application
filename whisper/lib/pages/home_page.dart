import 'package:flutter/material.dart';
import 'package:whisper/pages/contacts_page.dart';
import 'package:whisper/pages/chat_list_view.dart'; // Import the new ChatListView

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Whisper'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactsPage()),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Chats'),
            Tab(text: 'Groups'),
            Tab(text: 'Calls'),
          ],
        ),
      ),
      body: HomeTabBarView(tabController: _tabController),
    );
  }
}

class HomeTabBarView extends StatelessWidget {
  final TabController tabController;

  const HomeTabBarView({
    super.key, 
    required this.tabController
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        const ChatListView(), // Your new ChatListView
        const GroupListView(),
        const Center(child: Text('Calls')),
      ],
    );
  }
}

// Placeholder for GroupListView - replace with your actual implementation
class GroupListView extends StatelessWidget {
  const GroupListView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Groups will be implemented here'),
    );
  }
}