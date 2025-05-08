import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/screens/streaming_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EpisodeDetailsScreen extends StatefulWidget {
  final String title;

  const EpisodeDetailsScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<EpisodeDetailsScreen> createState() => _EpisodeDetailsScreenState();
}

class _EpisodeDetailsScreenState extends State<EpisodeDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildEpisodeTile(String title, String subtitle, String duration) {
    return ListTile(
      leading: GestureDetector(
        onTap: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>EpisodeDetailsScreen (title: 'Ramayan',)),
          );
        },
        child: Image.network(
          'https://i.ytimg.com/vi/Ei8oBTxHZcU/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDvR2ABOJcba3Ah1vy35rtMt9dorw',
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(duration),
          const Icon(Icons.download),
        ],
      ),
    );
  }

  Widget _buildShowCard(String imageUrl) {
    return Container(
      width: 100,
      margin: const EdgeInsets.all(8.0),
      child: Image.network(imageUrl, fit: BoxFit.cover),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Episode banner image
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

              const SizedBox(height: 10),
              // Episode details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Ramayan is an iconic Indian television series based on the ancient Sanskrit epic. '
                      'Created by Ramanand Sagar, it originally aired in 1987 and depicts the life of Lord Rama, ',

                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 14, height: 1.5),
                ),
              ),
              const SizedBox(height: 10),
              // TabBar with gradient indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'Season 1'),
                    Tab(text: 'Season 2'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // TabBarView for seasons
              SizedBox(
                height: 200,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(
                      children: [
                        buildEpisodeTile('S1 E1 - The Beginning', '6 Apr 2025', '10m'),
                        buildEpisodeTile('S1 E2 - The Journey', '13 Apr 2025', '12m'),
                        buildEpisodeTile('S1 E3 - The Challenge', '20 Apr 2025', '15m'),
                        buildEpisodeTile('S1 E3 - The Challenge', '20 Apr 2025', '15m'),
                        buildEpisodeTile('S1 E3 - The Challenge', '20 Apr 2025', '15m'),
                      ],
                    ),
                    ListView(
                      children: [
                        buildEpisodeTile('S2 E1 - The Return', '27 Apr 2025', '11m'),
                        buildEpisodeTile('S2 E2 - The Battle', '4 May 2025', '15m'),
                        buildEpisodeTile('S2 E3 - The Victory', '11 May 2025', '13m'),
                        buildEpisodeTile('S2 E3 - The Victory', '11 May 2025', '13m'),
                        buildEpisodeTile('S2 E3 - The Victory', '11 May 2025', '13m'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Popular Shows
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
            ],
          ),
        ),
      ),
    );
  }
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

