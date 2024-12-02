import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whisper/pages/signup/signup.dart';
import '../signup/signup.dart'; // Adjust import path as needed

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Logout function
  void _logout() {
    // Show confirmation dialog before logging out
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Navigate to login screen and remove all previous routes
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SignUp()),
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _loadProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Get data from Firestore
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users') // Assuming you have a 'users' collection
          .doc(user.uid)
          .get();

      var userData = doc.data() as Map<String, dynamic>;
      // If the document exists, load the data into controllers
      if (doc.exists) {
        _nameController.text = userData['name'] ?? '';
        _aboutController.text =
            userData['about'] ?? ''; // Use default value if not present
        _mobileController.text = userData['mobileNumber'] ?? '';
        _emailController.text = user.email ?? '';
      } else {
        // If document does not exist or fields are missing, use default values
        _aboutController.text = ''; // Default empty string for "about" field
      }
      print(userData);
    }
  }

  // Method to save updated data to Firestore
  void _saveProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid) // Replace with your user's ID
          .update({
        'name': _nameController.text,
        'about': _aboutController.text.isEmpty
            ? 'Add something about yourself'
            : _aboutController.text, // Update the about field
        'mobileNumber': _mobileController.text,
        'email': _emailController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')));
    } catch (e) {
      print("Error saving profile data: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error updating profile')));
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Call the function to load profile data
  }

  bool textEnable() {
    return false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header section with back and logout buttons
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFE0E0E0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Edit Your Profile',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Logout Button
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.red),
                    onPressed: _logout,
                    tooltip: 'Sign Out',
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Profile picture card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            // Profile Picture
                            Stack(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF38B6FF),
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/default_avatar.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF38B6FF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Profile details
                            _buildEditableField(
                              icon: Icons.person,
                              label: 'Name',
                              hint: 'Your Display Name',
                              controller: _nameController,
                            ),
                            _buildEditableField(
                              icon: Icons.info_outline,
                              label: 'About Me',
                              hint: 'Tell us about yourself',
                              controller: _aboutController,
                            ),
                            _buildEditableField(
                              icon: Icons.phone,
                              label: 'Mobile Number',
                              hint: 'Your Mobile Number',
                              controller: _mobileController,
                            ),
                            _buildEditableField(
                              icon: Icons.email,
                              label: 'Email',
                              hint: 'Your Email',
                              controller: _emailController,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Save button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _saveProfileData();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF38B6FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.save, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'SAVE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Encryption notice
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock, size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(
                            'All Data End-to-End Encrypted',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Editable field widget
  Widget _buildEditableField({
    required IconData icon,
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: controller.text.isEmpty ? hint : controller.text,
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF38B6FF)),
                onPressed: () {
                  // Implement here
                },
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
