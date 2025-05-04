import 'package:flutter/material.dart';

import 'HelpSupport_Screen.dart';
import 'Setting_Screen.dart';
import 'auth_Screen.dart';
import 'edit_profile.dart';
import 'notification.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Profile Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://example.com/user_avatar.jpg', // Replace with user's avatar URL
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'john.doe@example.com',
                    style: TextStyle(
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
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EditProfileScreen()),
                      ); // Navigate to Edit Profile Screen
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  NotificationsScreen()),
                      );// Navigate to Notifications Screen
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  SettingsScreen()),
                      );// Navigate to Settings Screen
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.help,
                    title: 'Help & Support',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  HelpSupportScreen()),
                      ); // Navigate to Help & Support Screen
                    },
                  ),
                  _buildProfileOption(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AuthScreen()),
                      ); // Handle logout functionality
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
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
      onTap: onTap,
    );
  }
}
