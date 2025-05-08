import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRewardScreen extends StatelessWidget {
  const MyRewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy reward data for the OTT app (you can replace this with real data from an API or provider)
    final List<String> rewards = [
      "Free 1-month subscription on your next renewal",
      "Watch 5 movies, get 1 free rental",
      "Exclusive early access to new content releases",
      "50% off on your next premium subscription"
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "My Rewards",
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: rewards.isEmpty
            ? _noRewardsView() // Show if no rewards
            : ListView.builder(
          itemCount: rewards.length,
          itemBuilder: (context, index) {
            return _buildRewardCard(rewards[index]);
          },
        ),
      ),
    );
  }

  // Build individual reward card
  Widget _buildRewardCard(String reward) {
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
                Icons.card_giftcard,
                color: Colors.blueAccent,
                size: 30,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  reward,
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

  // If no rewards are available, show this message
  Widget _noRewardsView() {
    return Center(
      child: Text(
        "You have no rewards yet!",
        style: GoogleFonts.roboto(
          color: Colors.white70,
          fontSize: 18,
        ),
      ),
    );
  }
}
