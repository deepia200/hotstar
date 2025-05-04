import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/screens/streaming_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> recentSearches = [
    'The Freelancer',
    'The Night Manager',
    'Criminal Justice',
    'Special Ops',
    'Aarya',
  ];

  final List<String> recentSearchImages = [
    'https://popcornreviewss.com/wp-content/uploads/2023/12/The-Freelancer-Volume-2-2023-Action-Thriller-Hindi-Review.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8mpWLhc0wGNeSI0041wUgaMoHPchTmgaDWw&s',
    'https://m.media-amazon.com/images/M/MV5BMDEwYTc5NWYtN2M1MS00ZmU4LWE3N2EtZTYxODgzYjg0NDA4XkEyXkFqcGc@._V1_.jpg',
    'https://i.pinimg.com/736x/40/41/93/404193e6b2b03eae8425b05515334829.jpg',
    'https://resizing.flixster.com/qfYrReTgPVNnjvscPgs5HnXK7HY=/ems.cHJkLWVtcy1hc3NldHMvdHZzZWFzb24vYjRlNzk1OTEtMDM2YS00NDAwLTg1MmEtNGE3NTA3MGVhMzE5LmpwZw==',
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

  final List<String> gridImages = [
    'https://m.media-amazon.com/images/M/MV5BYzNmZWRkMGQtZGU5NS00ODY0LTlmZjUtOTFiYmNjZjg4YzE0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
    'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_.jpg',
    'https://m.media-amazon.com/images/M/MV5BODIwMzkyNmItZjFmYy00MmEyLTlmM2UtZmQ2ODZlNjdkMWQ1XkEyXkFqcGc@._V1_QL75_UY207_CR4,0,140,207_.jpg',
    'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
    'https://i.pinimg.com/236x/8a/ee/df/8aeedf3a7d7edf3c435ad84f004c3cd5.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3TGnuUWH8H2rj48nsBUUPDrgrBQKHpyguCg&s',
    'https://m.media-amazon.com/images/M/MV5BYzM1MmNhMGQtNDliNy00ZDIwLTg1MDQtN2NjZjUyNTg2MGMxXkEyXkFqcGc@._V1_QL75_UX190_CR0,13,190,281_.jpg',
    'https://m.media-amazon.com/images/M/MV5BMjJmNGQ3NDgtZGMwOC00MTVhLTg5YjMtZGE1MDAxMGU3ZmRiXkEyXkFqcGc@._V1_.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7qzFXlLBp3DLCcHFob_6z_nXq8Hp0SCttR4IisNGQ1OMl5mG_-sYRCjYIBLupNa4LBNA&usqp=CAU',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.white54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Search for movies, shows, and more',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.mic, color: Colors.white54),
                    onPressed: () {
                      // Implement voice search functionality
                    },
                  ),
                ],
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
                  return Container(
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
                  );
                },
              ),
            ),

            SizedBox(height: 10),

            // Trending Categories
           Text(
              'Trending Categories',
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
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
                        style: const TextStyle(color: Colors.white),
                      ),
                      selected: false,
                      onSelected: (bool selected) {
                        // Implement category selection functionality
                      },
                      backgroundColor: Colors.grey[800],
                      selectedColor: Colors.blueAccent,
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
              itemCount: gridImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) =>  StreamingScreen()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(gridImages[index]),
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
