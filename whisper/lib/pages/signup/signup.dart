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
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(10), // Border radius for the box
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Shadow color
            spreadRadius: 5, // How much the shadow spreads
            blurRadius: 10, // How blurry the shadow is
            offset:
                const Offset(0, 5), // Shadow position (move shadow downward)
          ),
        ],
      ),
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

class AuthTabBarView extends StatefulWidget {
  const AuthTabBarView({super.key});

  @override
  State<AuthTabBarView> createState() => _AuthTabBarViewState();
}

class _AuthTabBarViewState extends State<AuthTabBarView> {
  late final loginEmailController = TextEditingController();
  late final loginPasswordController = TextEditingController();
  late final signupNameController = TextEditingController();
  late final signupPhoneController = TextEditingController();
  late final signupEmailController = TextEditingController();
  late final signupPasswordController = TextEditingController();
  late final signupConfirmPasswordController = TextEditingController();

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signupNameController.dispose();
    signupPhoneController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupConfirmPasswordController.dispose();
    super.dispose();
  }

  // global keys created for submit forms
  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeySignup = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        // Login Form
        SingleChildScrollView(
          child: Form(
            key: _formKeyLogin,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  child: TextFormField(
                    controller: loginEmailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  child: TextFormField(
                    controller: loginPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'Password must contain at least one uppercase letter';
                      }
                      if (!RegExp(r'[a-z]').hasMatch(value)) {
                        return 'Password must contain at least one lowercase letter';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Password must contain at least one number';
                      }
                      if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
                        return 'Password must contain at least one special character';
                      }
                      return null; // Password is valid
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKeyLogin.currentState!.validate()) {
                      // Navigate to Home on Login
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromRGBO(56, 182, 255, 1), // Button color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12), // Padding inside the button
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold), // Text style
                  ),
                ),
              ],
            ),
          ),
        ),
        // Signup Form
        SingleChildScrollView(
          child: Form(
            key: _formKeySignup,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  child: TextFormField(
                    controller: signupNameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }

                      if (value.length < 3) {
                        return 'Name must have atleast 3 characters';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  child: TextFormField(
                    controller: signupPhoneController,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      hintText: 'Enter your mobile number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      if (value.length != 10) {
                        return "Please enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  child: TextFormField(
                    controller: signupEmailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  child: TextFormField(
                    controller: signupPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'Password must contain at least one uppercase letter';
                      }
                      if (!RegExp(r'[a-z]').hasMatch(value)) {
                        return 'Password must contain at least one lowercase letter';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Password must contain at least one number';
                      }
                      if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
                        return 'Password must contain at least one special character';
                      }
                      return null; // Password is valid
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  child: TextFormField(
                    controller: signupConfirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm the password';
                      }
                      if (value != signupPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKeySignup.currentState!.validate()) {
                      // Navigate to Home on Login
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromRGBO(56, 182, 255, 1), // Button color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12), // Padding inside the button
                  ),
                  child: const Text(
                    'SIGNUP',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold), // Text style
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
