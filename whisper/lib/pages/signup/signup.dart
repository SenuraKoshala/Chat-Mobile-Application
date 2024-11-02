import 'package:flutter/material.dart';

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
            const Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        body: TabBar(
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
                            ]),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
