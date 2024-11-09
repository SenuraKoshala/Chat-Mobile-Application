import 'package:flutter/material.dart';
import 'package:whisper/pages/homePages/selectcontact.dart';

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
            padding: EdgeInsets.all(0.0),
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
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
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
        body: TabBarView(children: [
          Scaffold(
            body: const Text('Chats'),
            floatingActionButton: FloatingActionButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectContact()))
              },
              tooltip: 'New Contact',
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(Icons.add),
            ),
          ),
          const Text('Groups'),
          const Text('Calls')
        ]),
      ),
    );
  }
}
