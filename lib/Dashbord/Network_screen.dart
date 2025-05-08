import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/member_provider.dart';  // Import MemberProvider
import '../models/member_model.dart';     // Import Member model

class MyNetworkScreen extends StatelessWidget {
  const MyNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the list of members from the provider
    final members = Provider.of<MemberProvider>(context).members;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("My Network"),
        backgroundColor: Colors.black,
      ),
      body: members.isEmpty
          ? const Center(child: Text("No members added", style: TextStyle(color: Colors.white)))
          : ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: Colors.grey[850],
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Text(member.name, style: const TextStyle(color: Colors.white)),
              subtitle: Text('Email: ${member.email}\nUser ID: ${member.userId}',
                  style: const TextStyle(color: Colors.white70)),
            ),
          );
        },
      ),
    );
  }
}
