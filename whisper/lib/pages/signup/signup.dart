import 'package:flutter/material.dart';
import 'package:whisper/pages/homePages/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Navigation function for the login button
  void _navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 25),
            Expanded(child: LogoImage()),
            Expanded(flex: 2, child: AuthContainer()),
            Expanded(
              child: Padding(padding: EdgeInsets.only(bottom: 50.0)),
            ),
          ],
        ),
      ),
    );
  }
}

// Separate widget for the logo image
class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/logo_black.png');
  }
}

// Separate widget for the authentication container with tab view
class AuthContainer extends StatelessWidget {
  const AuthContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      decoration: authContainerDecoration,
      child: const DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(child: AuthTabBar()),
              Expanded(flex: 5, child: AuthTabBarView()),
            ],
          ),
        ),
      ),
    );
  }
}

// Separate widget for the tab bar
class AuthTabBar extends StatelessWidget {
  const AuthTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Color.fromRGBO(56, 182, 255, 1),
      tabs: [
        Tab(child: Text('Login')),
        Tab(child: Text('SignUp')),
      ],
    );
  }
}

// Separate widget for the tab bar view with forms
class AuthTabBarView extends StatelessWidget {
  const AuthTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        // Login Form
        Form(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Home on Login
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromRGBO(56, 182, 255, 1), // Button color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12), // Padding inside the button
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold), // Text style
                ),
              ),
            ],
          ),
        ),
        // Signup Form
        Form(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Enter your mobile number',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Home on Login
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(56, 182, 255, 1), // Button color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12), // Padding inside the button
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold), // Text style
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Styling constants
final authContainerDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 5,
      blurRadius: 10,
      offset: const Offset(0, 5),
    ),
  ],
);
