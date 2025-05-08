import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'Details_Screen.dart';
import 'home_Screen.dart';

class StreamingScreen extends StatelessWidget {
  const StreamingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Vimeo Video using WebView with Autoplay
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: WebViewWidget(
                      controller: WebViewController()
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..loadRequest(
                          Uri.parse(
                            'https://player.vimeo.com/video/1077793352?autoplay=1&muted=1',
                          ),
                        ),
                    ),
                  ),
                  // Add Back Button or Overlay if needed
                ],
              ),


              // Title and Info
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ramayan',
                      style: GoogleFonts.roboto(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Drama • Hindi • 1987',
                      style: GoogleFonts.roboto(fontSize: 12, color: Colors.blue),
                    ),
                    const SizedBox(height: 10),
        
                    // Watch Now + Share Row
                    Row(
                      children: [
                        // Full width "Watch Now" button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EpisodeDetailsScreen(title: 'Episode Title'),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.transparent,
                              elevation: 4,
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF2196F3), Color(0xFFE91E63)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(minHeight: 40),
                                child: const Text(
                                  'Watch Now',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
        
                        const SizedBox(width: 12),
        
                        // Share icon
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.grey[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              builder: (context) => ShareOptionsSheet(),
                            );
                          },
                          icon: const Icon(Icons.share, color: Colors.white),
                        ),
                      ],
                    ),
        
                    const SizedBox(height: 20),
                    Text(
                      'Ramayan is an iconic Indian television series based on the ancient Sanskrit epic. '
                          'Created by Ramanand Sagar, it originally aired in 1987 and depicts the life of Lord Rama, '
                          'his exile, the abduction of his wife Sita by Ravana, and the eventual victory of good over evil. '
                          'The show is revered for its cultural impact and remains a landmark in Indian television history.',
                      style: GoogleFonts.roboto(color: Colors.white, fontSize: 14, height: 1.5),
                    ),
        
        
        
                    const SizedBox(height: 10),
                    Text(
                      'Cast Details:',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '• Arun Govil as Ram\n'
                          '• Deepika Chikhalia as Sita\n'
                          '• Dara Singh as Hanuman\n'
                          '• Sunil Lahri as Lakshman',
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                  ],
                ),
              ),
        
              // Related Shows
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Related Shows',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const StreamingScreen()),
                        );
                      },
                      child: SizedBox(
                        height: 220,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(), // Optional smooth scroll
                          children: [
                            relatedShowCard(
                              'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg',
                            ),
                            relatedShowCard(
                              'https://akamaividz2.zee5.com/image/upload/w_756,h_1134,c_scale,f_webp,q_auto:eco/resources/0-6-300/portrait/1920x7701558563901558563909e660834d6014e26bb303fb89dc5b3aa.jpg',
                            ),
                            relatedShowCard(
                              'https://www.tvtime.com/_next/image?url=https%3A%2F%2Fartworks.thetvdb.com%2Fbanners%2Fv4%2Fseries%2F309259%2Fposters%2F614384858e577.jpg&w=640&q=75',
                            ),
                            relatedShowCard(
                              'https://www.tvtime.com/_next/image?url=https%3A%2F%2Fartworks.thetvdb.com%2Fbanners%2Fv4%2Fseries%2F309259%2Fposters%2F614384858e577.jpg&w=640&q=75',
                            ),
                            relatedShowCard(
                              'https://www.tvtime.com/_next/image?url=https%3A%2F%2Fartworks.thetvdb.com%2Fbanners%2Fv4%2Fseries%2F309259%2Fposters%2F614384858e577.jpg&w=640&q=75',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget relatedShowCard(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: 140,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
