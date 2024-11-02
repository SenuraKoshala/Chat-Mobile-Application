import 'package:flutter/material.dart';
import 'package:whisper/pages/signup/signup.dart';

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
                Expanded(flex: 2, child: Image.asset('assets/girl1.png'))
              ],
            )),
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
                ElevatedButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()))
                        },
                    child: Text('Slide to Start Now'))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
