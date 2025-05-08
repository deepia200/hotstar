import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

// Import your screens
import '../profile/AboutUs.dart';
import '../profile/change_mobileNo.dart';
import 'HelpSupport_Screen.dart';
import 'Setting_Screen.dart';
import 'Wallet_sacreen.dart';
import 'auth_Screen.dart';
import 'contectsupport_screen.dart';
import 'edit_profile.dart';
import 'forgot_password.dart';
import 'notification.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? _image; // The image selected by the user

  final ImagePicker _picker = ImagePicker();

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage; // Store the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String distributorId = 'D-102938'; // Get from Provider in real case
    final String userName = 'John Doe'; // Replace with provider later
    final String userEmail = 'john.doe@example.com';

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.account_balance_wallet),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletScreen()),
                ); // Navigate to Wallet Screen
              },
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                Share.share('Check out my KYC ID on the app!');
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Profile Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage, // Trigger image picker when tapped
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: _image == null
                          ? const NetworkImage('https://example.com/user_avatar.jpg')
                          : FileImage(File(_image!.path)) as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Distributor ID: $distributorId',
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userEmail,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white24),
            // Profile Options
            Expanded(
              child: ListView(
                children: [
                  _buildProfileOption(
                    icon: Icons.lock,
                    title: 'Change Password',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      ); // Navigate to Change Password screen
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.phone_android,
                    title: 'Update Mobile Number',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpdateMobileNumberScreen()),
                      );// Navigate to Update Mobile Number screen
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.info_outline,
                    title: 'About Us',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AboutUsScreen()),
                      );// Navigate to About Us screen
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.phone,
                    title: 'Contact Us',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ContactSupportScreen()),
                      );// Navigate to Contact Us screen
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.support_agent,
                    title: 'Support',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HelpSupportScreen())),
                  ),
                  _buildProfileOption(
                    icon: Icons.logout,
                    title: 'Sign Out',
                    onTap: () {
                      // Add logout logic
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => AuthScreen()),
                            (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
      onTap: onTap,
    );
  }
}
