import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/screens/streaming_screen.dart';
import '../bottamnavbar/side_Drawer.dart';
import '../service/api_service.dart';

class PopularShowsScreen extends StatefulWidget {
  const PopularShowsScreen({super.key});

  @override
  State<PopularShowsScreen> createState() => _PopularShowsScreenState();
}

class _PopularShowsScreenState extends State<PopularShowsScreen> {
  static const String _imageBaseUrl =
      'https://stag.aanandi.in/reel_life_otts/storage/app/public/';
  List<Map<String, dynamic>> popularShows = [];

  @override
  void initState() {
    super.initState();
    _loadPopularShows();
  }

  Future<void> _loadPopularShows() async {
    try {
      final data = await ApiService.fetchTopPopularShows(); // <-- Your API method
      setState(() {
        popularShows = data
            .map((item) => {
          ...item,
          'thumbnail': '$_imageBaseUrl${item['thumbnail']}',
        })
            .toList();
      });
    } catch (e) {
      print('Error loading popular shows: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: HotstarDrawer(),
      appBar: AppBar(
        title:
           Text(
            'Popular Shows',
            style: GoogleFonts.roboto(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: popularShows.isEmpty
            ? const Center(
          child: CircularProgressIndicator(color: Colors.white),
        )
            : Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: popularShows.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final item = popularShows[index];
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
        ),
      ),
    );
  }
}
