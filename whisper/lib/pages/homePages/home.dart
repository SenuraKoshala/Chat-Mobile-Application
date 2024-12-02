import 'package:flutter/material.dart';
import 'package:whisper/pages/chat/chat_list_view.dart';
import 'package:whisper/pages/contacts_page.dart';
import 'package:whisper/pages/group_list_view.dart';
import 'package:whisper/pages/profile/edit_profile.dart'; 

// Styling constants
const tabBarLabelColor = Color(0xFF38B6FF);
const tabBarIndicatorColor = Color(0xFF38B6FF);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }

  void _handleSearch(String query) {
    // Implement your search logic here
    // You can filter your chat list based on the query
    // and update the UI accordingly
  }

  void _handleMenuSelection(String value, BuildContext context) {
    switch (value) {
      case 'edit_profile':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditProfile()),
        );
        break;
      case 'favorite_chats':
        // Navigator.pushNamed(context, '/favorite-chats');
        break;
      case 'settings':
        // Navigator.pushNamed(context, '/settings');
        break;
      case 'report_issue':
        // Navigator.pushNamed(context, '/report-issue');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context);
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: AppBar(
                leading: _isSearching
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: _stopSearch,
                      )
                    : const AppLogo(),
                title: _isSearching
                    ? TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                        ),
                        onChanged: _handleSearch,
                      )
                    : null,
                actions: [
                  IconButton(
                    icon: Icon(_isSearching ? Icons.clear : Icons.search),
                    onPressed: _isSearching ? _stopSearch : _startSearch,
                  ),
                  if (!_isSearching)
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      position: PopupMenuPosition.under,
                      elevation: 3,
                      offset: const Offset(0, 0), // Adjust this to position the menu
                      itemBuilder: (BuildContext context) => [
                        _buildPopupMenuItem(
                          value: 'edit_profile',
                          icon: Icons.person,
                          text: 'Edit Profile',
                        ),
                        _buildPopupMenuItem(
                          value: 'favorite_chats',
                          icon: Icons.favorite,
                          text: 'Favorite Chats',
                        ),
                        _buildPopupMenuItem(
                          value: 'settings',
                          icon: Icons.settings,
                          text: 'Settings',
                        ),
                        _buildPopupMenuItem(
                          value: 'report_issue',
                          icon: Icons.report_problem,
                          text: 'Report an Issue',
                        ),
                      ],
                      onSelected: (String value) => _handleMenuSelection(value, context),
                    ),
                ],
                bottom: _isSearching ? null : const HomeTabBar(),
              ),
            ),
            body: const HomeTabBarView(),
            floatingActionButton: AnimatedBuilder(
              animation: tabController,
              builder: (context, child) {
                return tabController.index == 0
                    ? FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ContactsPage(),
                            ),
                          );
                        },
                        backgroundColor: const Color(0xFF38B6FF),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24,
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        },
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem({
    required String value,
    required IconData icon,
    required String text,
  }) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF38B6FF), size: 20),
          const SizedBox(width: 12),
          Text(text),
        ],
      ),
    );
  }
}

// Separate widget for the logo
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Image.asset(
          'assets/logo_white.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

// Separate widget for the TabBar
class HomeTabBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      labelColor: tabBarLabelColor,
      indicatorColor: tabBarIndicatorColor,
      tabs: [
        Tab(text: 'Chats'),
        Tab(text: 'Groups'),
        Tab(text: 'Calls'),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

// Separate widget for TabBarView
class HomeTabBarView extends StatelessWidget {
  const HomeTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        ChatListView(), // Import from chat/chat_list_view.dart
        const GroupListView(),
        const Center(child: Text('Calls')),
      ],
    );
  }
}