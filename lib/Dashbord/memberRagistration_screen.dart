import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/member_provider.dart';  // Import MemberProvider
import '../models/member_model.dart';     // Import Member model

class NewMemberRegistrationScreen extends StatefulWidget {
  const NewMemberRegistrationScreen({super.key});

  @override
  _NewMemberRegistrationScreenState createState() => _NewMemberRegistrationScreenState();
}

class _NewMemberRegistrationScreenState extends State<NewMemberRegistrationScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _userIdController = TextEditingController();

  // This function will be triggered when the user submits the registration form
  void _registerNewMember() {
    final name = _nameController.text;
    final email = _emailController.text;
    final userId = _userIdController.text;

    if (name.isEmpty || email.isEmpty || userId.isEmpty) {
      // Show a message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
      return;
    }

    // Create a new member and add it using the provider
    final newMember = Member(name: name, email: email, userId: userId);
    Provider.of<MemberProvider>(context, listen: false).addMember(newMember);

    // After adding the member, navigate to the MyNetworkScreen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("New Member Registration"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _userIdController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "User ID",
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _registerNewMember,
              child: const Text("Register Member"),
            ),
          ],
        ),
      ),
    );
  }
}
