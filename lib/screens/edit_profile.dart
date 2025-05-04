// lib/screens/edit_profile_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';


class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    _nameController = TextEditingController(text: profile.name);
    _emailController = TextEditingController(text: profile.email);
    _passwordController = TextEditingController(text: profile.password);
    super.initState();
  }

  Future<void> _pickImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image != null) {
      Provider.of<ProfileProvider>(context, listen: false)
          .updateProfileImage(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: profileProvider.profileImage != null
                    ? FileImage(profileProvider.profileImage!)
                    : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.camera_alt, size: 28),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                profileProvider.updateProfile(
                  _nameController.text,
                  _emailController.text,
                  _passwordController.text,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Profile updated")),
                );
              },
              child: Text("Save Changes"),
            )
          ],
        ),
      ),
    );
  }
}
