import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/screens/streaming_screen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // For dot indicator
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../provider/auth_provider.dart';
import 'Details_Screen.dart';
import 'Wallet_sacreen.dart';
import 'auth_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _autoScrollTimer;
  bool isLoggedIn = false;

  final List<Map<String, String>> _featuredItems = [
    {"type": "image", "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiLtIIWEJqFjmaldRuo1ZBbmbKqbXPXW52y-Ls9L-0lWoYL4iuOHKl5ZI3GG9OHyxm0pU&usqp=CAU'"},
    {"type": "video", "url": "https://player.vimeo.com/video/1077793352?autoplay=1&muted=0"},
    {"type": "image", "url": "https://dt87jj20glo1t.cloudfront.net/assets/ENTERR10/EPISODE/63360386abe8c9102e378b02/images/1920px-X-1080px_2.jpg"},
  ];


  List<String> categories = [
    'Action',
    'Comedy',
    'Drama',
    'Horror',
    'Romance',
    'Thriller',
    'Sci-Fi',
  ];
  String selectedCategory = 'Action';

  Map<String, List<String>> categoryImages = {
    'Action': [
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',
    ],
    'Comedy': [
      'https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',
      'https://i.pinimg.com/236x/fd/f4/e1/fdf4e1bf438375284d5625566b316d13.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
    ],
    'Drama': [
      'https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
    ],
    'Horror': [
      'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
    ],
    'Romance': [
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
    ],
    'Thriller': [
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
    ],
    'Sci-Fi': [
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
    ],
    // Add entries for other categories...
  };

  final List<Map<String, dynamic>> _contentItems = [
    {
      'imageUrl': 'https://i.pinimg.com/236x/fd/f4/e1/fdf4e1bf438375284d5625566b316d13.jpg',
      'progress': 0.7,
      'episodeInfo': 'S1E2 · 12 Jan 2024',
    },
    {
      'imageUrl': 'https://i.pinimg.com/236x/e8/db/43/e8db43ef4e515e274a46e881e210f3b6.jpg',
      'progress': 0.3,
      'episodeInfo': 'S2E5 · 5 Feb 2024',
    },
    {
      'imageUrl': 'https://i.pinimg.com/236x/da/46/81/da4681204b4479d68b553c853f1b465f.jpg',
      'progress': 0.9,
      'episodeInfo': 'S3E1 · 20 Mar 2024',
    },
  ];


  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _autoScrollTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % _featuredItems.length;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false);


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback:
              (bounds) => LinearGradient(
                colors: [Colors.blue, Colors.pink],
                tileMode: TileMode.mirror,
              ).createShader(bounds),
          child: Text(
            'ReelLife',
            style: GoogleFonts.roboto(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.account_balance_wallet, color: Colors.white),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletScreen()),
              );// Navigate to wallet
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
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
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              _buildHeroSection(),
              _buildCategoriesSection(),
              _buildContinueWatchingSection(),
              _buildPopularShowsSection(),
              _buildPopularInMythologySection(),
              _buildDramaShowsSection(),
              _buildReferAndEarnBanner(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _featuredItems.length,
            itemBuilder: (context, index) {
              final item = _featuredItems[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: item['type'] == 'image'
                    ? Image.network(item['url']!, fit: BoxFit.cover)
                    : WebViewWidget(
                  controller: WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..loadRequest(Uri.parse(item['url']!)),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: _featuredItems.length,
            effect: const ExpandingDotsEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.white,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildContinueWatchingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          'Continue Watching',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
       SizedBox(
         width: double.infinity,
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _contentItems.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = _contentItems[index];
              return _buildTappableContentCard(
                imageUrl: item['imageUrl']!,
                progress: item['progress']!,
                episodeInfo: item['episodeInfo']!,
              );
            },
          ),
        )
          ,
      ],
    );
  }

  Widget _buildTappableContentCard({
    required String imageUrl,
    required double progress,
    required String episodeInfo,
  }) {
    return Container(
      width: 230,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          GestureDetector(
            onTap: (){
              // if (!isLoggedIn) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => AuthScreen()),
              //   ); // Redirect to login screen
              // } else {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => EpisodeDetailsScreen(title: "Ramayan"),
              //     ),
              //   );
              // }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EpisodeDetailsScreen(title: "Ramayan"),
                ),
              );
            },
            child: Container(
              height: 150,
              width: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 4),
          // Episode Info
          Text(
            episodeInfo,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
                categories.map((category) {
                  final isSelected = selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.black : Colors.white70,
                      ),
                      selectedColor: Colors.white,
                      backgroundColor: Colors.grey[800],
                    ),
                  );
                }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
                (categoryImages[selectedCategory] ?? [])
                    .map((imageUrl) => _buildBigContentCard(imageUrl))
                    .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPopularShowsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Shows',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildBigContentCard(
                'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
              ),
              _buildBigContentCard(
                'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg',
              ),
              _buildBigContentCard(
                'https://m.media-amazon.com/images/M/MV5BMjJmNGQ3NDgtZGMwOC00MTVhLTg5YjMtZGE1MDAxMGU3ZmRiXkEyXkFqcGc@._V1_.jpg',
              ),
              _buildBigContentCard(
                'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
              ),
              _buildBigContentCard(
                'https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPopularInMythologySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'Popular In Mythology',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildBigContentCard(
                'https://www.tvtime.com/_next/image?url=https%3A%2F%2Fartworks.thetvdb.com%2Fbanners%2Fv4%2Fseries%2F309259%2Fposters%2F614384858e577.jpg&w=640&q=75',
              ),
              _buildBigContentCard(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3TGnuUWH8H2rj48nsBUUPDrgrBQKHpyguCg&s',
              ),
              _buildBigContentCard(
                'https://m.media-amazon.com/images/M/MV5BYzM1MmNhMGQtNDliNy00ZDIwLTg1MDQtN2NjZjUyNTg2MGMxXkEyXkFqcGc@._V1_QL75_UX190_CR0,13,190,281_.jpg',
              ),
              _buildBigContentCard(
                'https://m.media-amazon.com/images/M/MV5BMWU1OTliM2YtM2I3OS00NTlmLTk4YmQtYWI0ODRiMWZlNGExXkEyXkFqcGc@._V1_.jpg',
              ),
              _buildBigContentCard(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoM6v-ZoScuBFutrVjlriPIW2UL2fBlLBGs-j08QySVJDvT1AXxCXsIG-Mygne_yY2840&usqp=CAU',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReferAndEarnBanner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          height: 180,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: NetworkImage(
                'https://img.freepik.com/premium-vector/people-share-info-about-referral-earn-money-landing-page-template_95505-155.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildDramaShowsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'Drama Shows',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildBigContentCard(
                'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg',
              ),
              _buildBigContentCard(
                'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
              ),
              _buildBigContentCard(
                'https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',
              ),
              _buildBigContentCard(
                'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
              ),
              _buildBigContentCard(
                'https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBigContentCard(
    String imageUrl, {
    double height = 220,
    double width = 140,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          // if (!isLoggedIn) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => AuthScreen()),
          //   ); // Redirect to login screen
          // } else {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (_) => StreamingScreen()), // Go to Streaming
          //   );
          // }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => StreamingScreen()), // Go to Streaming
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: height,
            width: width,
          ),
        ),
      ),
    );
  }
}

class ShareOptionsSheet extends StatelessWidget {
  const ShareOptionsSheet({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Wrap(
        runSpacing: 25,
        children: [
          const Center(
            child: Text(
              "Share via",
              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCustomIconButton(
                imagePath: 'assets/icon/whatsapp.png',
                label: 'WhatsApp',
                onTap: () => _launchURL("https://wa.me/?text=Check out ReelLife!"),
              ),
              _buildCustomIconButton(
                imagePath: 'assets/icon/Telegram.png',
                label: 'Telegram',
                onTap: () => _launchURL(
                  "https://t.me/share/url?url=https://your-link.com",
                ),
              ),
              _buildCustomIconButton(
                imagePath: 'assets/icon/instagram.png',
                label: 'Instagram',
                onTap: () => _launchURL("https://www.instagram.com"),
              ),
              _buildCustomIconButton(
                imagePath: 'assets/icon/Facebook.png',
                label: 'Facebook',
                onTap: () => _launchURL(
                  "https://www.facebook.com/sharer/sharer.php?u=https://your-link.com",
                ),
              ),
            ],
          ),



        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.share,
              color: Colors.black,
            ), // icon param not used here, fix:
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
// if (!isLoggedIn) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => AuthScreen()),
//   ); // Redirect to login screen
// } else {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => EpisodeDetailsScreen(title: "Ramayan"),
//     ),
//   );
// }
Widget _buildCustomIconButton({
  required String imagePath,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Image.asset(
          imagePath,
          width: 40,
          height: 40,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    ),
  );
}
