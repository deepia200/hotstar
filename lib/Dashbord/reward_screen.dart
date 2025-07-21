import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../service/api_methods.dart';

class MyRewardScreen extends StatefulWidget {
  const MyRewardScreen({super.key});

  @override
  State<MyRewardScreen> createState() => _MyRewardScreenState();
}

class _MyRewardScreenState extends State<MyRewardScreen> {
  late Future<List<Map<String, dynamic>>> _rewardsFuture;

  @override
  void initState() {
    super.initState();
    _rewardsFuture = ApiMethods.fetchAllRewards();
  }

  String formatDate(String timestamp) {
    if (timestamp.isEmpty || timestamp == "0") return "N/A";
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _rewardsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
              return _noRewardsView();
            } else {
              final rewards = snapshot.data!;
              return ListView.builder(
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  final reward = rewards[index];
                  final title = reward['reward_title'] ?? 'Untitled';
                  final startDate = formatDate(reward['start_date'] ?? '');
                  final endDate = formatDate(reward['end_date'] ?? '');

                  return _buildRewardCard(title, startDate, endDate);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildRewardCard(String reward, String startDate, String endDate) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.date_range, color: Colors.orange, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    "From $startDate → $endDate",
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

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
