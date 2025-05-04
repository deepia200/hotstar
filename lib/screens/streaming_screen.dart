import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import 'Details_Screen.dart';

class StreamingScreen extends StatefulWidget {
  const StreamingScreen({Key? key}) : super(key: key);

  @override
  State<StreamingScreen> createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late TabController _tabController;
  final String videoUrl = 'http://bit.ly/RamayanHindi';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Widget buildVideoPlayer() {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          VideoPlayer(_controller),
          VideoProgressIndicator(_controller, allowScrubbing: true),
          _PlayPauseOverlay(controller: _controller),
        ],
      ),
    );
  }

  Widget buildEpisodeTile(String title, String subtitle, String duration) {
    return ListTile(
      leading: Image.network(
        'https://i.ytimg.com/vi/Ei8oBTxHZcU/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDvR2ABOJcba3Ah1vy35rtMt9dorw',
        width: 100,
        fit: BoxFit.cover,
      ),
      title: Text(title,style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),),
      subtitle: Text(subtitle),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(duration),
          Icon(Icons.download),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_controller.value.isInitialized) buildVideoPlayer(),
            Stack(
              children: [
                // Full-width Image
                SizedBox(
                  width: double.infinity,
                  height: 300, // Adjust height as needed
                  child: Image.network(
                    'https://i.pinimg.com/236x/6f/d0/e1/6fd0e10c820304a87ce7a2c9c1bae7eb.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                // Back Button Positioned at Top-Left
                Positioned(
                  top: 10, // Adjust for status bar height
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black, size: 40, weight: 700,),
                    onPressed: () {
                      Navigator.pop(context); // Navigates back
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 320),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EpisodeDetailsScreen(title: 'Episode Title'),
                          ),
                        );// Your onPressed logic here
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        backgroundColor: Colors.transparent, // Makes the background transparent
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF2196F3), Color(0xFFE91E63)], // Replace with your desired colors
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(minWidth: 100, minHeight: 40),
                          child: Text(
                            'Watch Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      SizedBox(width: 10,),
                      Icon(Icons.add, color: Colors.white,),
                      SizedBox(width: 25),
                      Icon(Icons.share, color: Colors.white),
                      SizedBox(width: 25),
                      Icon(Icons.star_border, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Details of the show go here... Classic Indian epic retold.',
                    style:  GoogleFonts.roboto(color: Colors.white),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs:  [
                Tab(text: 'Season 1',),
                Tab(text: 'Season 2'),
              ],
            ),
            SizedBox(
              height: 200,
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    children: [
                      buildEpisodeTile(
                          'S1 E1 - The Beginning', '6 Apr 2025', '10m',),
                      buildEpisodeTile(
                          'S1 E2 - The Journey', '13 Apr 2025', '12m'),
                      buildEpisodeTile(
                          'S1 E2 - The Journey', '13 Apr 2025', '12m'),
                      buildEpisodeTile(
                          'S1 E2 - The Journey', '13 Apr 2025', '12m'),
                      buildEpisodeTile(
                          'S1 E2 - The Journey', '13 Apr 2025', '12m'),
                      buildEpisodeTile(
                          'S1 E2 - The Journey', '13 Apr 2025', '12m'),
                    ],
                  ),
                  ListView(
                    children: [
                      buildEpisodeTile(
                          'S2 E1 - The Return', '20 Apr 2025', '11m'),
                      buildEpisodeTile(
                          'S2 E2 - The Battle', '27 Apr 2025', '15m'),
                      buildEpisodeTile(
                          'S2 E2 - The Battle', '27 Apr 2025', '15m'),
                      buildEpisodeTile(
                          'S2 E2 - The Battle', '27 Apr 2025', '15m'),
                      buildEpisodeTile(
                          'S2 E2 - The Battle', '27 Apr 2025', '15m'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Popular Shows',
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 200,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const StreamingScreen()),
                  );
                },
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    popularCard(
                        'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg'),
                    popularCard(
                        'https://akamaividz2.zee5.com/image/upload/w_756,h_1134,c_scale,f_webp,q_auto:eco/resources/0-6-300/portrait/1920x7701558563901558563909e660834d6014e26bb303fb89dc5b3aa.jpg'),
                    popularCard(
                        'https://www.tvtime.com/_next/image?url=https%3A%2F%2Fartworks.thetvdb.com%2Fbanners%2Fv4%2Fseries%2F309259%2Fposters%2F614384858e577.jpg&w=640&q=75'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  Widget popularCard(String imageUrl) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: 140,
        ),
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  final VideoPlayerController controller;

  const _PlayPauseOverlay({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.value.isPlaying ? controller.pause() : controller.play();
      },
      child: Container(
        color: Colors.black26,
        child: Center(
          child: Icon(
            controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: 60.0,
          ),
        ),
      ),
    );
  }
}