import 'package:flutter/material.dart';
import 'package:whisper/pages/homePages/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Expanded(child: Image.asset('assets/logo_black.png')),
            Expanded(
                flex: 2,
                child: Container(
                  width: 300.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.5), // Color of the shadow with opacity
                        spreadRadius: 5, // Extent of the shadow spread
                        blurRadius: 10, // Softness of the shadow
                        offset:
                            const Offset(0, 5), // Offset in x and y direction
                      ),
                    ],
                  ),
                  child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        body: Column(
                          children: [
                            const Expanded(
                                child: TabBar(
                                    labelColor: Colors.black,
                                    unselectedLabelColor: Colors.grey,
                                    indicatorColor: Colors.blue,
                                    tabs: [
                                  Tab(
                                    child: Text('Login'),
                                  ),
                                  Tab(
                                    child: Text('SignUp'),
                                  )
                                ])),
                            Expanded(
                                flex: 5,
                                child: TabBarView(children: [
                                  Form(
                                      child: Column(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Home()));
                                          },
                                          child: const Text('LOGIN'))
                                    ],
                                  )),
                                  Form(
                                      child: Column(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: const Text('SIGNUP'))
                                    ],
                                  ))
                                ]))
                          ],
                        ),
                      )),
                )),
            const Expanded(
                child: Padding(padding: EdgeInsets.only(bottom: 50.0)))
          ],
        ),
      ),
    );
  }
}
