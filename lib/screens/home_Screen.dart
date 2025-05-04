import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/screens/streaming_screen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // For dot indicator
import '../provider/auth_provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final List<String> _featuredImages = [
    'https://dt87jj20glo1t.cloudfront.net/assets/ENTERR10/EPISODE/63360386abe8c9102e378b02/images/1920px-X-1080px_2.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiLtIIWEJqFjmaldRuo1ZBbmbKqbXPXW52y-Ls9L-0lWoYL4iuOHKl5ZI3GG9OHyxm0pU&usqp=CAU',
    'https://s3images.coroflot.com/user_files/individual_files/70314_drt5tbodwzivnz7axry6dj0e6.jpg',
  ];

  List<String> categories = ['Action', 'Comedy', 'Drama', 'Horror', 'Romance', 'Thriller', 'Sci-Fi'];
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


  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Colors.blue, Colors.pink],
              tileMode: TileMode.mirror,
            ).createShader(bounds),
            child: Text(
              'Hotstar',
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,

              ),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
              children: [
                _buildHeroSection(),
                _buildCategoriesSection(),
                _buildContinueWatchingSection(),
                _buildPopularShowsSection(),
                _buildPopularInMythologySection(),
                _buildDramaShowsSection(),
              ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _featuredImages.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  _featuredImages[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: _featuredImages.length,
            effect: const ExpandingDotsEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.white,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            width: 180,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.pink],
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child:  Text(
                'Watch Now',
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              ),
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
          height: 200, // Adjusted height to accommodate all elements
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildTappableContentCard(
                imageUrl: 'https://i.pinimg.com/236x/fd/f4/e1/fdf4e1bf438375284d5625566b316d13.jpg',
                progress: 0.7,
                episodeInfo: 'S1E2 · 12 Jan 2024',
              ),
              _buildTappableContentCard(
                imageUrl: 'https://i.pinimg.com/236x/e8/db/43/e8db43ef4e515e274a46e881e210f3b6.jpg',
                progress: 0.3,
                episodeInfo: 'S2E5 · 5 Feb 2024',
              ),
              _buildTappableContentCard(
                imageUrl: 'https://i.pinimg.com/236x/da/46/81/da4681204b4479d68b553c853f1b465f.jpg',
                progress: 0.9,
                episodeInfo: 'S3E1 · 20 Mar 2024',
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTappableContentCard({
    required String imageUrl,
    required double progress,
    required String episodeInfo,
  }) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 150,
            width: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
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
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
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
            children: categories.map((category) {
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
            children: (categoryImages[selectedCategory] ?? [])
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
          style:GoogleFonts.roboto(
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
              _buildBigContentCard('https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg'),
              _buildBigContentCard('https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg'),
              _buildBigContentCard('https://m.media-amazon.com/images/M/MV5BMjJmNGQ3NDgtZGMwOC00MTVhLTg5YjMtZGE1MDAxMGU3ZmRiXkEyXkFqcGc@._V1_.jpg'),
              _buildBigContentCard('https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg'),
              _buildBigContentCard('https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg'),
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
              _buildBigContentCard('https://www.tvtime.com/_next/image?url=https%3A%2F%2Fartworks.thetvdb.com%2Fbanners%2Fv4%2Fseries%2F309259%2Fposters%2F614384858e577.jpg&w=640&q=75'),
              _buildBigContentCard('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3TGnuUWH8H2rj48nsBUUPDrgrBQKHpyguCg&s',),
              _buildBigContentCard( 'https://m.media-amazon.com/images/M/MV5BYzM1MmNhMGQtNDliNy00ZDIwLTg1MDQtN2NjZjUyNTg2MGMxXkEyXkFqcGc@._V1_QL75_UX190_CR0,13,190,281_.jpg',),
              _buildBigContentCard('https://m.media-amazon.com/images/M/MV5BMWU1OTliM2YtM2I3OS00NTlmLTk4YmQtYWI0ODRiMWZlNGExXkEyXkFqcGc@._V1_.jpg'),
              _buildBigContentCard('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoM6v-ZoScuBFutrVjlriPIW2UL2fBlLBGs-j08QySVJDvT1AXxCXsIG-Mygne_yY2840&usqp=CAU'),
            ],
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
              _buildBigContentCard('https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg'),
              _buildBigContentCard('https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg'),
              _buildBigContentCard('https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',),
              _buildBigContentCard('https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',),
              _buildBigContentCard('https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',),
            ],
          ),
        ),
      ],
    );
  }



  Widget _buildBigContentCard(String imageUrl, {double height = 220, double width = 140}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const StreamingScreen()),
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
