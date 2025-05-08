import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/help_provider.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> faqs = const [
    {
      'question': 'How do I reset my password?',
      'answer': 'To reset your password, go to the login screen and tap on "Forgot Password". Follow the instructions sent to your registered email.'
    },
    {
      'question': 'How can I update my payment method?',
      'answer': 'Navigate to Account Settings > Payment Methods to update your payment information.'
    },
    {
      'question': 'Why is my video buffering?',
      'answer': 'Buffering can occur due to slow internet connections. Please check your internet speed or try restarting your router.'
    },
    {
      'question': 'How do I contact customer support?',
      'answer': 'You can reach out to our support team via the "Contact Us" section in the app or by emailing support@hotstar.com.'
    },
  ];

  Future<void> _openWhatsAppChat() async {
    final phoneNumber = '+911234567890'; // Replace with your actual support number
    final message = Uri.encodeComponent("Hi, I need help with the Hotstar app.");
    final url = Uri.parse("https://wa.me/$phoneNumber?text=$message");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@hotstar.com',
      query: Uri.encodeFull('subject=App Support&body=Hi, I need help with the app.'),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not open email client';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HelpProvider(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Help & Support',
            style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<HelpProvider>(
            builder: (context, provider, child) {
              return ListView(
                children: [
                  const Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...faqs.map((faq) {
                    final isExpanded = provider.isExpanded(faq['question']!);
                    return Card(
                      color: Colors.grey[900],
                      child: ExpansionTile(
                        title: Text(
                          faq['question']!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              faq['answer']!,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                        ],
                        onExpansionChanged: (_) {
                          provider.toggleItem(faq['question']!);
                        },
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                  const Text(
                    'Need more help?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // WhatsApp Button
                  GestureDetector(
                    onTap: _openWhatsAppChat,
                    child: const Text(
                      '+911234567890',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),


                  const SizedBox(height: 12),

                  // Email Support Link
                  GestureDetector(
                    onTap: _sendEmail,
                    child: const Text(
                      'support@reellife.com',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
