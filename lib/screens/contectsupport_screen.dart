import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../service/api_methods.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  _ContactSupportScreenState createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  final _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a message')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message Sent!')),
    );
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 16),

            // 📦 API Data Box
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black87,
              ),
              padding: const EdgeInsets.all(16),
              child: FutureBuilder<String>(
                future: ApiMethods.fetchContactMessage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white));
                  } else if (snapshot.hasError) {
                    return Text(
                      'Failed to load message: ${snapshot.error}',
                      style: const TextStyle(color: Colors.redAccent),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Text(
                        snapshot.data ?? '',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  }
                },
              ),
            ),



          ],
        ),
      ),
    );
  }
}
