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
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(
                'assets/logo_white.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
          bottom: const TabBar(
              labelColor: Color(0xFF38B6FF),
              indicatorColor: Color(0xFF38B6FF),
              tabs: [
                Tab(
                  text: 'Chats',
                ),
                Tab(
                  text: 'Groups',
                ),
                Tab(
                  text: 'Calls',
                )
              ]),
        ),
        body: const TabBarView(
            children: [Text('Chats'), Text('Groups'), Text('Calls')]),
      ),
    );
  }
}
