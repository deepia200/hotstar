import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

import '../Dashbord/Detail_screen.dart';
import '../screens/Wallet_sacreen.dart';
import '../service/api_methods.dart';


class SchemeScreen extends StatefulWidget {
  const SchemeScreen({super.key});

  @override
  State<SchemeScreen> createState() => _SchemeScreenState();
}

class _SchemeScreenState extends State<SchemeScreen> {
  late Future<List<Map<String, dynamic>>> _schemeFuture;

  @override
  void initState() {
    super.initState();
    _schemeFuture = ApiMethods.fetchSchemeData();
  }

  String formatUnixDate(String timestamp) {
    if (timestamp.isEmpty || timestamp == "0") return "N/A";
    try {
      final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return "Invalid date";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Available Schemes',
          style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const MyIncomeScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              Share.share('Check out this awesome content on ReelLife!');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _schemeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No schemes available.",
                style: GoogleFonts.roboto(color: Colors.white70),
              ),
            );
          } else {
            final schemes = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: schemes.length,
              itemBuilder: (context, index) {
                final scheme = schemes[index];
                final title = scheme['reward_title'] ?? 'No Title';
                final img = scheme['img'] ?? '';
                final start = scheme['start_date'] ?? '';
                final end = scheme['end_date'] ?? '';
                final time = scheme['time'] ?? '';
                final imageUrl = img.isNotEmpty
                    ? 'https://stag.aanandi.in/mlm_ott/public/images/$img'
                    : null;

                final startFormatted = formatUnixDate(start);
                final endFormatted = formatUnixDate(end);

                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.only(bottom: 16),
                  color: Colors.grey[900],
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Section
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: imageUrl != null
                              ? Image.network(
                            imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image_sharp, size: 50, color: Colors.grey),
                          )
                              : const Icon(Icons.image, size: 50, color: Colors.grey),
                        ),
                        const SizedBox(width: 12),

                        // Text Section
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Valid from $startFormatted to $endFormatted"
                                    "${time.isNotEmpty ? " ($time days)" : ""}",
                                style: GoogleFonts.roboto(fontSize: 12, color: Colors.orangeAccent),
                              ),
                              const SizedBox(height: 10),
                              // Align(
                              //   alignment: Alignment.centerRight,
                              //   child: ElevatedButton(
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor: Colors.blue,
                              //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              //     ),
                              //     onPressed: () {
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //         SnackBar(content: Text('$title clicked')),
                              //       );
                              //     },
                              //     child: Text(
                              //       'Know More',
                              //       style: GoogleFonts.roboto(color: Colors.white),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
