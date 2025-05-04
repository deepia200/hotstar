import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/setting_provider.dart';
// Ensure this path is correct

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: ListView(
              children: [
                SwitchListTile(
                  title: const Text(
                    'Enable Notifications',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: settingsProvider.notificationsEnabled,
                  onChanged: settingsProvider.toggleNotifications,
                  activeColor: Colors.blueAccent,
                ),
                SwitchListTile(
                  title: const Text(
                    'Dark Mode',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: settingsProvider.darkMode,
                  onChanged: settingsProvider.toggleDarkMode,
                  activeColor: Colors.blueAccent,
                ),
                ListTile(
                  title: const Text(
                    'Account Settings',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onTap: () {
                    // Navigate to account settings
                  },
                ),
                ListTile(
                  title: const Text(
                    'Help & Support',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onTap: () {
                    // Navigate to help & support
                  },
                ),
                ListTile(
                  title: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  onTap: () {
                    // Implement log out functionality
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
