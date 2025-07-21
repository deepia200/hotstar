import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../service/api_methods.dart';

class MyAwardScreen extends StatefulWidget {
  const MyAwardScreen({super.key});

  @override
  State<MyAwardScreen> createState() => _MyAwardScreenState();
}

class _MyAwardScreenState extends State<MyAwardScreen> {
  late Future<List<Map<String, dynamic>>> _rewardsFuture;

  @override
  void initState() {
    super.initState();
    _rewardsFuture = ApiMethods.fetchAllRewards(); // make sure this fetches your API
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
          "My Awards",
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _rewardsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return _noAwardsView();
          } else {
            final rewards = snapshot.data!;
            return ListView.builder(
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                final reward = rewards[index];
                final title = reward['reward_title'] ?? 'No Title';
                final start = formatDate(reward['start_date'] ?? '');
                final end = formatDate(reward['end_date'] ?? '');
                final isActive = reward['status'] == 'on';
                final img = reward['img'] ?? '';
                final imageUrl = img.isNotEmpty
                    ? 'https://stag.aanandi.in/mlm_ott/public/images/$img'
                    : null;

                return _buildAwardCard(title, start, end, isActive, imageUrl);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildAwardCard(String title, String startDate, String endDate, bool isActive, String? imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Card(
        color: isActive ? Colors.grey[850] : Colors.grey[800],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Opacity(
            opacity: isActive ? 1.0 : 0.5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image preview
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imageUrl != null
                      ? Image.network(
                    imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  )
                      : const Icon(Icons.image, size: 50, color: Colors.grey),
                ),
                const SizedBox(width: 12),

                // Text Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: isActive ? Colors.yellowAccent : Colors.grey,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              title,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.event, size: 16, color: Colors.green),
                          const SizedBox(width: 6),
                          Text(
                            "Received on $startDate",
                            style: GoogleFonts.roboto(
                              color: Colors.greenAccent,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


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
