import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAwardScreen extends StatelessWidget {
  const MyAwardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy awards data (replace with real data from an API or provider)
    final List<String> awards = [
      "Top Watcher: 100 hours of content viewed",
      "Early Bird: First to watch the new release",
      "Premium Member: 1 year of continuous subscription",
      "Exclusive Access: VIP User Status",
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "My Awards",
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: awards.isEmpty
            ? _noAwardsView() // Show if no awards
            : ListView.builder(
          itemCount: awards.length,
          itemBuilder: (context, index) {
            return _buildAwardCard(awards[index]);
          },
        ),
      ),
    );
  }

  // Build individual award card
  Widget _buildAwardCard(String award) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellowAccent,
                size: 30,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  award,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // If no awards are available, show this message
  Widget _noAwardsView() {
    return Center(
      child: Text(
        "You have no awards yet!",
        style: GoogleFonts.roboto(
          color: Colors.white70,
          fontSize: 18,
        ),
      ),
    );
  }
}
