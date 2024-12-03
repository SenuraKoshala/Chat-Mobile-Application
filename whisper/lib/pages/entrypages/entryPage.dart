import 'package:flutter/material.dart';
import 'package:whisper/pages/signup/signup.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart'; // Import the swipe button package

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            Expanded(child: Image.asset('assets/logo_black.png')),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(flex: 3, child: Image.asset('assets/boy2.png')),
                  Expanded(child: Image.asset('assets/right-arrow2.png')),
                  Expanded(flex: 2, child: Image.asset('assets/girl1.png')),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'Now You Are',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Text(
                    'Connected',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SwipeButton.expand(
                    thumb: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    activeThumbColor: Colors.blue,
                    activeTrackColor: const Color.fromARGB(255, 233, 232, 232),
                    onSwipe: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: const Text(
                      'Swipe to Start Now',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
