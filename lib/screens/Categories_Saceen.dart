import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/screens/streaming_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Dashbord/Detail_screen.dart';
import '../bottamnavbar/side_Drawer.dart';
import '../service/api_service.dart';
import 'Wallet_sacreen.dart';
import '../service/api_methods.dart'; // Make sure this contains getHomeData()
import 'dart:convert';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  Future<bool> isMemberUser() async {
    final prefs = await SharedPreferences.getInstance();
    final memberType = prefs.getString('memberType') ?? '';
    return memberType == '0';
  }

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  static const String _imageBaseUrl =
      'https://stag.aanandi.in/reel_life_otts/storage/app/public/';

  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;

  Map<String, dynamic>? homeData;
  List<String> categories = [];
  Map<String, List<Map<String, dynamic>>> categoryItems = {};
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _fetchHomeData();
  }

  Future<void> _fetchHomeData() async {
    try {
      final data = await ApiService.getHomeData();
      if (data != null && data['status'] == 'success') {
        setState(() {
          homeData = data['data'];

          final apiCategories = homeData?['categories'] as Map<String, dynamic>;

          categoryItems = {};
          categories = [];

          apiCategories.forEach((key, value) {
            final List<dynamic> itemList = value;
            if (itemList.isNotEmpty) {
              final List<Map<String, dynamic>> processedList = itemList
                  .cast<Map<String, dynamic>>()
                  .map((item) => {
                ...item,
                'thumbnail': '$_imageBaseUrl${item['thumbnail']}',
              })
                  .toList();

              categoryItems[key] = processedList;
              categories.add(key); // Only add non-empty categories
            }
          });

          selectedCategory = categories.isNotEmpty ? categories.first : '';
        });
      }
    } catch (e) {
      print('Error fetching home data: $e');
    }
  }


  List<Map<String, dynamic>> get filteredGridItems {
    if (categories.isEmpty ||
        !categoryItems.containsKey(categories[_selectedCategoryIndex])) {
      return [];
    }

    return categoryItems[categories[_selectedCategoryIndex]]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: HotstarDrawer(),
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
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
        // actions: [
        //   FutureBuilder<bool>(
        //     future: widget.isMemberUser(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const SizedBox.shrink();
        //       }
        //       final isMember = snapshot.data ?? false;
        //       if (isMember) {
        //         return IconButton(
        //           icon: const Icon(Icons.account_balance_wallet,
        //               color: Colors.white),
        //           onPressed: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const MyIncomeScreen()),
        //             );
        //           },
        //         );
        //       } else {
        //         return const SizedBox.shrink();
        //       }
        //     },
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.share, color: Colors.white),
        //     onPressed: () {
        //       Share.share('Check out this awesome content!');
        //     },
        //   ),
        // ],
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: categories.isEmpty
            ? const Center(
          child: CircularProgressIndicator(color: Colors.white),
        )
            : ListView(
          padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          children: [
            const SizedBox(height: 20),
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
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredGridItems.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final item = filteredGridItems[index];
                final imageUrl = item['thumbnail'] ?? '';
                final title = item['movie_name'] ?? 'Untitled';
                final contentId = item['id'];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StreamingScreen(
                          contentId: contentId,
                          title: title,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
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
