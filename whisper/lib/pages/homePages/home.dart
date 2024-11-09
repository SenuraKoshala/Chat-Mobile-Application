import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context);
          return Scaffold(
            appBar: const HomeAppBar(),
            body: const HomeTabBarView(),
            floatingActionButton: AnimatedBuilder(
              animation: tabController,
              builder: (context, child) {
                return tabController.index == 0
                    ? FloatingActionButton(
                        onPressed: () {
                          // Add action for new chat
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
}

// Separate widget for the AppBar
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const AppLogo(),
      actions: const [
        IconButton(onPressed: _onSearchPressed, icon: Icon(Icons.search)),
        IconButton(onPressed: _onMorePressed, icon: Icon(Icons.more_vert)),
      ],
      bottom: const HomeTabBar(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
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
    return const TabBarView(
      children: [
        Center(child: Text('Chats')),
        Center(child: Text('Groups')),
        Center(child: Text('Calls')),
      ],
    );
  }
}

// Styling constants
const tabBarLabelColor = Color(0xFF38B6FF);
const tabBarIndicatorColor = Color(0xFF38B6FF);

// Functions for button actions
void _onSearchPressed() {
  // Action for search button
}

void _onMorePressed() {
  // Action for more button
}