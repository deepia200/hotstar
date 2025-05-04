import 'package:flutter/material.dart';

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
      leading: Image.network(
        'https://i.ytimg.com/vi/Ei8oBTxHZcU/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDvR2ABOJcba3Ah1vy35rtMt9dorw',
        width: 100,
        fit: BoxFit.cover,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Episode banner image
              Stack(
                children:[ Image.network(
                  'https://i.ytimg.com/vi/Ei8oBTxHZcU/hq720.jpg',
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
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
              const SizedBox(height: 10),
              // Episode details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Episode Details: S1E2 - Release Date: Jan 1, 2025',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Popular Shows',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildShowCard('https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg'),
                    _buildShowCard('https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg'),
                    _buildShowCard('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3TGnuUWH8H2rj48nsBUUPDrgrBQKHpyguCg&s'),
                    _buildShowCard('https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg'),
                    _buildShowCard('https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg'),
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
