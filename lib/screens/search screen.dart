import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/screens/streaming_screen.dart';

import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashbord/Detail_screen.dart';
import '../bottamnavbar/side_Drawer.dart';

import 'Wallet_sacreen.dart';


class SearchScreen extends StatefulWidget {
  Future<bool> isMemberUser() async {
    final prefs = await SharedPreferences.getInstance();
    final memberType = prefs.getString('memberType') ?? '';
    return memberType == '0';
  }
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isLoggedIn = false;

  final List<String> recentSearches = [
    'The Freelancer',
    'The Night Manager',
    'Criminal Justice',
    'Special Ops',
    'Aarya',
  ];

  final List<String> recentSearchImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8mpWLhc0wGNeSI0041wUgaMoHPchTmgaDWw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8mpWLhc0wGNeSI0041wUgaMoHPchTmgaDWw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8mpWLhc0wGNeSI0041wUgaMoHPchTmgaDWw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8mpWLhc0wGNeSI0041wUgaMoHPchTmgaDWw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8mpWLhc0wGNeSI0041wUgaMoHPchTmgaDWw&s',
    'https://example.com/rrr.jpg',
    'https://example.com/bhool_bhulaiyaa_2.jpg',
    'https://example.com/pathaan.jpg',
  ];

  final List<String> categories = [
    'Action',
    'Comedy',
    'Drama',
    'Thriller',
    'Romance',
    'Horror',
    'Sci-Fi',
    'Documentary',
  ];

  int _selectedCategoryIndex = 0;

  final Map<String, List<String>> categoryImageMap = {
    'Action': [
      'https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',
      'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
      'https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3TGnuUWH8H2rj48nsBUUPDrgrBQKHpyguCg&s',
      'https://m.media-amazon.com/images/M/MV5BYzM1MmNhMGQtNDliNy00ZDIwLTg1MDQtN2NjZjUyNTg2MGMxXkEyXkFqcGc@._V1_QL75_UX190_CR0,13,190,281_.jpg',
      'https://m.media-amazon.com/images/M/MV5BMjJmNGQ3NDgtZGMwOC00MTVhLTg5YjMtZGE1MDAxMGU3ZmRiXkEyXkFqcGc@._V1_.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7qzFXlLBp3DLCcHFob_6z_nXq8Hp0SCttR4IisNGQ1OMl5mG_-sYRCjYIBLupNa4LBNA&usqp=CAU',
    ],
    'Comedy': [
      'https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',
      'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
      'https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3TGnuUWH8H2rj48nsBUUPDrgrBQKHpyguCg&s',
      'https://m.media-amazon.com/images/M/MV5BYzM1MmNhMGQtNDliNy00ZDIwLTg1MDQtN2NjZjUyNTg2MGMxXkEyXkFqcGc@._V1_QL75_UX190_CR0,13,190,281_.jpg',
      'https://m.media-amazon.com/images/M/MV5BMjJmNGQ3NDgtZGMwOC00MTVhLTg5YjMtZGE1MDAxMGU3ZmRiXkEyXkFqcGc@._V1_.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7qzFXlLBp3DLCcHFob_6z_nXq8Hp0SCttR4IisNGQ1OMl5mG_-sYRCjYIBLupNa4LBNA&usqp=CAU',
    ],
    'Drama': [
      'https://m.media-amazon.com/images/M/MV5BMjJmNGQ3NDgtZGMwOC00MTVhLTg5YjMtZGE1MDAxMGU3ZmRiXkEyXkFqcGc@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',
      'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
      'https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3TGnuUWH8H2rj48nsBUUPDrgrBQKHpyguCg&s',
      'https://m.media-amazon.com/images/M/MV5BYzM1MmNhMGQtNDliNy00ZDIwLTg1MDQtN2NjZjUyNTg2MGMxXkEyXkFqcGc@._V1_QL75_UX190_CR0,13,190,281_.jpg',
      'https://m.media-amazon.com/images/M/MV5BMjJmNGQ3NDgtZGMwOC00MTVhLTg5YjMtZGE1MDAxMGU3ZmRiXkEyXkFqcGc@._V1_.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7qzFXlLBp3DLCcHFob_6z_nXq8Hp0SCttR4IisNGQ1OMl5mG_-sYRCjYIBLupNa4LBNA&usqp=CAU',
    ],
    'Thriller': [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3TGnuUWH8H2rj48nsBUUPDrgrBQKHpyguCg&s',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',
      'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
      'https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3TGnuUWH8H2rj48nsBUUPDrgrBQKHpyguCg&s',
      'https://m.media-amazon.com/images/M/MV5BYzM1MmNhMGQtNDliNy00ZDIwLTg1MDQtN2NjZjUyNTg2MGMxXkEyXkFqcGc@._V1_QL75_UX190_CR0,13,190,281_.jpg',
      'https://m.media-amazon.com/images/M/MV5BMjJmNGQ3NDgtZGMwOC00MTVhLTg5YjMtZGE1MDAxMGU3ZmRiXkEyXkFqcGc@._V1_.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7qzFXlLBp3DLCcHFob_6z_nXq8Hp0SCttR4IisNGQ1OMl5mG_-sYRCjYIBLupNa4LBNA&usqp=CAU',
    ],
    'Romance': [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7qzFXlLBp3DLCcHFob_6z_nXq8Hp0SCttR4IisNGQ1OMl5mG_-sYRCjYIBLupNa4LBNA&usqp=CAU',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',
      'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
      'https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3TGnuUWH8H2rj48nsBUUPDrgrBQKHpyguCg&s',
      'https://m.media-amazon.com/images/M/MV5BYzM1MmNhMGQtNDliNy00ZDIwLTg1MDQtN2NjZjUyNTg2MGMxXkEyXkFqcGc@._V1_QL75_UX190_CR0,13,190,281_.jpg',
      'https://m.media-amazon.com/images/M/MV5BMjJmNGQ3NDgtZGMwOC00MTVhLTg5YjMtZGE1MDAxMGU3ZmRiXkEyXkFqcGc@._V1_.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7qzFXlLBp3DLCcHFob_6z_nXq8Hp0SCttR4IisNGQ1OMl5mG_-sYRCjYIBLupNa4LBNA&usqp=CAU',
    ],
    'Horror': [
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',
      'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
      'https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3TGnuUWH8H2rj48nsBUUPDrgrBQKHpyguCg&s',
      'https://m.media-amazon.com/images/M/MV5BYzM1MmNhMGQtNDliNy00ZDIwLTg1MDQtN2NjZjUyNTg2MGMxXkEyXkFqcGc@._V1_QL75_UX190_CR0,13,190,281_.jpg',
      'https://m.media-amazon.com/images/M/MV5BMjJmNGQ3NDgtZGMwOC00MTVhLTg5YjMtZGE1MDAxMGU3ZmRiXkEyXkFqcGc@._V1_.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7qzFXlLBp3DLCcHFob_6z_nXq8Hp0SCttR4IisNGQ1OMl5mG_-sYRCjYIBLupNa4LBNA&usqp=CAU',
    ],
    'Sci-Fi': [
      'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',
      'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
      'https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3TGnuUWH8H2rj48nsBUUPDrgrBQKHpyguCg&s',
      'https://m.media-amazon.com/images/M/MV5BYzM1MmNhMGQtNDliNy00ZDIwLTg1MDQtN2NjZjUyNTg2MGMxXkEyXkFqcGc@._V1_QL75_UX190_CR0,13,190,281_.jpg',
      'https://m.media-amazon.com/images/M/MV5BMjJmNGQ3NDgtZGMwOC00MTVhLTg5YjMtZGE1MDAxMGU3ZmRiXkEyXkFqcGc@._V1_.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7qzFXlLBp3DLCcHFob_6z_nXq8Hp0SCttR4IisNGQ1OMl5mG_-sYRCjYIBLupNa4LBNA&usqp=CAU',
    ],
    'Documentary': [
      'https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',
      'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
      'https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',
      'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
      'https://m.media-amazon.com/images/M/MV5BMjJmNGQ3NDgtZGMwOC00MTVhLTg5YjMtZGE1MDAxMGU3ZmRiXkEyXkFqcGc@._V1_.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7qzFXlLBp3DLCcHFob_6z_nXq8Hp0SCttR4IisNGQ1OMl5mG_-sYRCjYIBLupNa4LBNA&usqp=CAU',
      'https://m.media-amazon.com/images/M/MV5BYzM1MmNhMGQtNDliNy00ZDIwLTg1MDQtN2NjZjUyNTg2MGMxXkEyXkFqcGc@._V1_QL75_UX190_CR0,13,190,281_.jpg',
      'https://m.media-amazon.com/images/M/MV5BMjJmNGQ3NDgtZGMwOC00MTVhLTg5YjMtZGE1MDAxMGU3ZmRiXkEyXkFqcGc@._V1_.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7qzFXlLBp3DLCcHFob_6z_nXq8Hp0SCttR4IisNGQ1OMl5mG_-sYRCjYIBLupNa4LBNA&usqp=CAU',
    ],
  };

  List<String> get filteredGridImages {
    final selectedCategory = categories[_selectedCategoryIndex];
    return categoryImageMap[selectedCategory] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: HotstarDrawer(),
      appBar: AppBar(
        title:
        // Important to apply gradient to image
        //     Image.asset(
        //   'assets/images/logo.png', // Make sure this is added in pubspec.yaml
        //   height: 50,
        //   fit: BoxFit.contain,
        // ),

          ShaderMask(
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

        actions: [
          FutureBuilder<bool>(
            future: widget.isMemberUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox.shrink();
              }
              final isMember = snapshot.data ?? false;
              if (isMember) {
                return IconButton(
                  icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyIncomeScreen()),
                    );
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () {
              Share.share('Check out this awesome content!');
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 60, // Increased height
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // Slightly more rounded
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ), // Increased horizontal padding
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.white54,
                      size: 28,
                    ), // Slightly larger icon
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ), // Slightly larger font
                        decoration: const InputDecoration(
                          hintText: 'Search for movies, shows, and more',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.mic,
                        color: Colors.white54,
                        size: 28,
                      ), // Larger mic icon
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => VoiceSearchScreen()),
                        // );// Implement voice search functionality
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Recent Searches
            Text(
              'Recent Searches',
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StreamingScreen(),
                        ), // Go to Streaming
                      );
                    },

                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.only(right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 6),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(recentSearchImages[index]),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            recentSearches[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10),

            const SizedBox(height: 10),

            // Trending Categories
            Text(
              'Trending Categories',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        categories[index],
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: _selectedCategoryIndex == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                      backgroundColor: Colors.grey[800],
                      selectedColor: Colors.white38,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Image Grid
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredGridImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StreamingScreen(),
                      ), // Go to Streaming
                    );
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(filteredGridImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
