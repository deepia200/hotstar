

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/screens/streaming_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Dashbord/Detail_screen.dart';
import '../bottamnavbar/side_Drawer.dart';
import '../provider/auth_provider.dart';
import '../service/api_service.dart';
import 'Wallet_sacreen.dart';
import 'auth_Screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  Future<bool> isMemberUser() async {
    final prefs = await SharedPreferences.getInstance();
    final memberType = prefs.getString('memberType') ?? '';
    return memberType == '0';
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String _imageBaseUrl = 'https://stag.aanandi.in/reel_life_otts/storage/app/public/';
  static const String _placeholderImage = '${_imageBaseUrl}placeholder.jpg';
  PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _autoScrollTimer;
  Map<String, dynamic>? homeData;
  List<Map<String, String>> _featuredItems = [];
  List<String> categories = [];
  Map<String, List<Map<String, dynamic>>> categoryItems = {};
  List<Map<String, dynamic>> _contentItems = [];
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _fetchHomeData();
    _pageController = PageController();

    _autoScrollTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients && _featuredItems.isNotEmpty) {
        _currentPage = (_currentPage + 1) % _featuredItems.length;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _fetchHomeData() async {
    try {
      imageCache.clear();
      imageCache.clearLiveImages();
      final data = await ApiService.getHomeData();
      if (data != null && data['status'] == 'success') {
        setState(() {
          homeData = data['data'];
          final featured = homeData?['featured'];
          _featuredItems = [
            {
              'type': 'image',
              'url': featured != null && featured['thumbnail'] != null && featured['thumbnail'].isNotEmpty
                  ? '$_imageBaseUrl${featured['thumbnail']}'
                  : _placeholderImage
            },
            {
              'type': 'video',
              'url': featured != null && featured['trailer_url'] != null && featured['trailer_url'].isNotEmpty
                  ? featured['trailer_url']
                  : 'https://example.com/placeholder.mp4'
            },
          ];

          // Log all thumbnail URLs for debugging
          print('Featured Thumbnail: ${_featuredItems[0]['url']}');
          final apiCategories = homeData?['categories'] as Map<String, dynamic>;
          categories = apiCategories.keys.toList();
          categoryItems = apiCategories.map(
                (key, value) => MapEntry(
              key,
              (value as List<dynamic>).cast<Map<String, dynamic>>().map((item) {
                final thumbnail = item['thumbnail'] != null && item['thumbnail'].isNotEmpty
                    ? '$_imageBaseUrl${item['thumbnail']}'
                    : _placeholderImage;
                print('Category $key Thumbnail: $thumbnail');
                return {
                  ...item,
                  'thumbnail': thumbnail,
                };
              }).toList(),
            ),
          );

          selectedCategory = categories.isNotEmpty ? categories.first : '';

          _contentItems = (homeData?['categories']['Sports'] as List<dynamic>? ?? [])
              .cast<Map<String, dynamic>>()
              .take(3)
              .map((item) {
            final thumbnail = item['thumbnail'] != null && item['thumbnail'].isNotEmpty
                ? '$_imageBaseUrl${item['thumbnail']}'
                : _placeholderImage;
            print('Continue Watching Thumbnail: $thumbnail');
            return {
              'imageUrl': thumbnail,
              'progress': 0.5,
              'episodeInfo': 'S1E${item['id']} · ${item['release_year']}',
              'id': item['id'],
              'title': item['movie_name'],
            };
          }).toList();
        });
      } else {
        print('API Error: Status not success or data null');
      }
    } catch (e) {
      print('Error fetching home data: $e');
    }
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: HotstarDrawer(),
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
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
          FutureBuilder<bool>(
            future: widget.isMemberUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox.shrink();
              }
              final isMember = snapshot.data ?? false;
              if (authProvider.isAuthenticated && isMember) {
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
      ),
      body: homeData == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              _buildHeroSection(),
              _buildCategoriesSection(),
              if (authProvider.isAuthenticated) _buildContinueWatchingSection(),
              _buildPopularShowsSection(),
              SizedBox(height: 10),
              _buildgenresSection(),
              SizedBox(height: 20),
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
          height: MediaQuery.of(context).size.height / 4,
          child: _featuredItems.isEmpty
              ? Center(child: CircularProgressIndicator())
              : PageView.builder(
            controller: _pageController,
            itemCount: _featuredItems.length,
            itemBuilder: (context, index) {
              final item = _featuredItems[index];
              return GestureDetector(
                onTap: () {
                  if (item['type'] == 'image' && homeData?['featured'] != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StreamingScreen(
                          contentId: homeData!['featured']['id'] ?? 0,
                          title: homeData!['featured']['movie_name'] ?? 'No Title',
                        ),
                      ),
                    );
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: item['type'] == 'image'
                      ? Image.network(
                    item['url']!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        print('Image loaded successfully: ${item['url']}');
                        return child;
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print('Image failed to load: ${item['url']} - Error: $error');
                      return Container(
                        color: Colors.grey[800],
                        child: Icon(Icons.broken_image, color: Colors.white70),
                      );
                    },
                  )
                      /*: WebViewWidget(
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..loadRequest(Uri.parse(item['url']!))
                      ..setNavigationDelegate(
                        NavigationDelegate(
                          onPageFinished: (url) {
                            print('Video loaded successfully: $url');
                          },
                          onWebResourceError: (error) {
                            print('Video failed to load: ${item['url']} - Error: ${error.description}');
                          },
                        ),
                      ),
                  ),*/
                  : SizedBox(),
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
          height: MediaQuery.of(context).size.height / 5.4,
          child: _contentItems.isEmpty
              ? Center(child: Text('No items to continue watching', style: TextStyle(color: Colors.white)))
              : ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            itemCount: _contentItems.length,
            separatorBuilder: (context, index) => SizedBox(width: 8),
            itemBuilder: (context, index) {
              final item = _contentItems[index];
              return _buildTappableContentCard(
                imageUrl: item['imageUrl']!,
                progress: item['progress']!,
                episodeInfo: item['episodeInfo']!,
                contentId: item['id'],
                title: item['title'],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTappableContentCard({
    required String imageUrl,
    required double progress,
    required String episodeInfo,
    required int contentId,
    required String title,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
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
              height: MediaQuery.of(context).size.height / 7,
              width: MediaQuery.of(context).size.width / 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    print('Image failed to load: $imageUrl - Error: $exception');
                  },
                ),
              ),
              child: imageUrl == _placeholderImage
                  ? Center(child: Icon(Icons.broken_image, color: Colors.white70))
                  : null,
            ),
          ),
          const SizedBox(height: 6),
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
          Text(
            episodeInfo,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final validCategories = categories.where((category) => (categoryItems[category] ?? []).isNotEmpty).toList();

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
          height: MediaQuery.of(context).size.width / 10,
          child: validCategories.isEmpty
              ? Center(child: Text('No categories available', style: TextStyle(color: Colors.white)))
              : ListView(
            scrollDirection: Axis.horizontal,
            children: validCategories.map((category) {
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
          height: MediaQuery.of(context).size.height / 5,
          child: (categoryItems[selectedCategory] ?? []).isEmpty
              ? Center(child: Text('No items in $selectedCategory', style: TextStyle(color: Colors.white)))
              : ListView(
            scrollDirection: Axis.horizontal,
            children: (categoryItems[selectedCategory] ?? [])
                .map((item) => _buildBigContentCard(
              item['thumbnail'],
              contentId: item['id'],
              title: item['movie_name'],
            ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPopularShowsSection() {
    final popularItems = categoryItems.entries.expand((entry) => entry.value).take(10).toList();

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
          height: MediaQuery.of(context).size.height / 5,
          child: popularItems.isEmpty
              ? Center(child: Text('No popular shows available', style: TextStyle(color: Colors.white)))
              : ListView(
            scrollDirection: Axis.horizontal,
            children: popularItems
                .map((item) => _buildBigContentCard(
              item['thumbnail'],
              contentId: item['id'],
              title: item['movie_name'],
            ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBigContentCard(
      String imageUrl, {
        double height = 220,
        double width = 140,
        required int contentId,
        required String title,
      }) {
    debugPrint("yvuvf:"+imageUrl);
    final effectiveImageUrl = imageUrl.isNotEmpty ? imageUrl : _placeholderImage;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StreamingScreen(
                contentId: contentId,
                title: title,
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            "$effectiveImageUrl",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width / 3 - 18,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                print('Image loaded successfully: $effectiveImageUrl');
                return child;
              }
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              print('Image failed to load: $effectiveImageUrl - Error: $error');
              return Container(
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width / 3 - 18,
                color: Colors.grey[800],
                child: Icon(Icons.broken_image, color: Colors.white70),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildgenresSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categoryItems.entries
          .where((entry) => entry.value.isNotEmpty)
          .map((entry) {
        final category = entry.key;
        final items = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
              child: Text(
                category,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                children: items
                    .map((item) => _buildBigContentCard(
                  item['thumbnail'],
                  contentId: item['id'],
                  title: item['movie_name'],
                ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      }).toList(),
    );
  }
}

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hotstar/screens/streaming_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../Dashbord/Detail_screen.dart';
// import '../bottamnavbar/side_Drawer.dart';
// import '../provider/auth_provider.dart';
// import '../service/api_service.dart';
// import 'Wallet_sacreen.dart';
// import 'auth_Screen.dart';
// import 'package:http/http.dart' as http;
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   Future<bool> isMemberUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final memberType = prefs.getString('memberType') ?? '';
//     return memberType == '0';
//   }
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   static const String _imageBaseUrl = 'https://stag.aanandi.in/reel_life_otts/storage/app/public/';
//   PageController _pageController = PageController();
//   int _currentPage = 0;
//   late Timer _autoScrollTimer;
//   Map<String, dynamic>? homeData;
//   List<Map<String, String>> _featuredItems = [];
//   List<String> categories = [];
//   Map<String, List<Map<String, dynamic>>> categoryItems = {};
//   List<Map<String, dynamic>> _contentItems = [];
//   String selectedCategory = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchHomeData();
//     _pageController = PageController();
//
//     _autoScrollTimer = Timer.periodic(Duration(seconds: 3), (timer) {
//       if (_pageController.hasClients && _featuredItems.isNotEmpty) {
//         _currentPage = (_currentPage + 1) % _featuredItems.length;
//         _pageController.animateToPage(
//           _currentPage,
//           duration: Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }
//
//   Future<void> _fetchHomeData() async {
//     try {
//       final data = await ApiService.getHomeData();
//       if (data != null && data['status'] == 'success') {
//         setState(() {
//           homeData = data['data'];
//           final featured = homeData?['featured'];
//           _featuredItems = [
//             {'type': 'image', 'url': '$_imageBaseUrl${featured['thumbnail']}'},
//             {'type': 'video', 'url': featured['trailer_url']},
//           ];
//
//           final apiCategories = homeData?['categories'] as Map<String, dynamic>;
//           categories = apiCategories.keys.toList();
//           categoryItems = apiCategories.map(
//                 (key, value) => MapEntry(
//               key,
//               (value as List<dynamic>).cast<Map<String, dynamic>>().map((item) {
//                 return {
//                   ...item,
//                   'thumbnail': '$_imageBaseUrl${item['thumbnail']}',
//                 };
//               }).toList(),
//             ),
//           );
//
//           selectedCategory = categories.isNotEmpty ? categories.first : '';
//
//           _contentItems = (homeData?['categories']['Sports'] as List<dynamic>? ?? [])
//               .cast<Map<String, dynamic>>()
//               .take(3)
//               .map((item) => {
//             'imageUrl': '$_imageBaseUrl${item['thumbnail']}',
//             'progress': 0.5,
//             'episodeInfo': 'S1E${item['id']} · ${item['release_year']}',
//             'id': item['id'],
//             'title': item['movie_name'],
//           })
//               .toList();
//         });
//       }
//     } catch (e) {
//       print('Error fetching home data: $e');
//     }
//   }
//
//   @override
//   void dispose() {
//     _autoScrollTimer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       drawer: HotstarDrawer(),
//       appBar: AppBar(
//         title: ShaderMask(
//           shaderCallback: (bounds) => LinearGradient(
//             colors: [Colors.blue, Colors.pink],
//             tileMode: TileMode.mirror,
//           ).createShader(bounds),
//           child: Text(
//             'ReelLife',
//             style: GoogleFonts.roboto(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         elevation: 0,
//         actions: [
//           FutureBuilder<bool>(
//             future: widget.isMemberUser(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return SizedBox.shrink();
//               }
//               final isMember = snapshot.data ?? false;
//               if (authProvider.isAuthenticated && isMember) {
//                 return IconButton(
//                   icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const MyIncomeScreen()),
//                     );
//                   },
//                 );
//               } else {
//                 return SizedBox.shrink();
//               }
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.share, color: Colors.white),
//             onPressed: () {
//               Share.share('Check out this awesome content!');
//             },
//           ),
//         ],
//       ),
//       body: homeData == null
//           ? Center(child: CircularProgressIndicator())
//           : SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: ListView(
//             children: [
//               _buildHeroSection(),
//               _buildCategoriesSection(),
//               if (authProvider.isAuthenticated) _buildContinueWatchingSection(),
//               _buildPopularShowsSection(),
//               SizedBox(height: 10),
//               _buildgenresSection(),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeroSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height / 4,
//           child: _featuredItems.isEmpty
//               ? Center(child: CircularProgressIndicator())
//               : PageView.builder(
//             controller: _pageController,
//             itemCount: _featuredItems.length,
//             itemBuilder: (context, index) {
//               final item = _featuredItems[index];
//               return GestureDetector(
//                 onTap: () {
//                   if (item['type'] == 'image' && homeData?['featured'] != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => StreamingScreen(
//                           contentId: homeData!['featured']['id'] ?? 0,
//                           title: homeData!['featured']['movie_name'] ?? 'No Title',
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(4),
//                   child: item['type'] == 'image'
//                       ? Image.network(
//                     item['url']!,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Center(
//                         child: Text('Image not found', style: TextStyle(color: Colors.white)),
//                       );
//                     },
//                   )
//                       : WebViewWidget(
//                     controller: WebViewController()
//                       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//                       ..loadRequest(Uri.parse(item['url']!)),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 10),
//         Center(
//           child: SmoothPageIndicator(
//             controller: _pageController,
//             count: _featuredItems.length,
//             effect: const ExpandingDotsEffect(
//               dotColor: Colors.grey,
//               activeDotColor: Colors.white,
//               dotHeight: 8,
//               dotWidth: 8,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildContinueWatchingSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 10),
//         Text(
//           'Continue Watching',
//           style: GoogleFonts.roboto(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height / 5.4,
//           child: _contentItems.isEmpty
//               ? Center(child: Text('No items to continue watching', style: TextStyle(color: Colors.white)))
//               : ListView.separated(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             itemCount: _contentItems.length,
//             separatorBuilder: (context, index) => SizedBox(width: 8),
//             itemBuilder: (context, index) {
//               final item = _contentItems[index];
//               return _buildTappableContentCard(
//                 imageUrl: item['imageUrl']!,
//                 progress: item['progress']!,
//                 episodeInfo: item['episodeInfo']!,
//                 contentId: item['id'],
//                 title: item['title'],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTappableContentCard({
//     required String imageUrl,
//     required double progress,
//     required String episodeInfo,
//     required int contentId,
//     required String title,
//   }) {
//     return Container(
//       width: MediaQuery.of(context).size.width / 2,
//       margin: const EdgeInsets.only(right: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => StreamingScreen(
//                     contentId: contentId,
//                     title: title,
//                   ),
//                 ),
//               );
//             },
//             child: Container(
//               height: MediaQuery.of(context).size.height / 7,
//               width: MediaQuery.of(context).size.width / 1,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(4),
//                 image: DecorationImage(
//                   image: NetworkImage(imageUrl),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 6),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(4),
//             child: LinearProgressIndicator(
//               value: progress,
//               backgroundColor: Colors.white24,
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
//               minHeight: 4,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             episodeInfo,
//             style: const TextStyle(color: Colors.white70, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCategoriesSection() {
//     final validCategories = categories.where((category) => (categoryItems[category] ?? []).isNotEmpty).toList();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Categories',
//           style: GoogleFonts.roboto(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: MediaQuery.of(context).size.width / 10,
//           child: validCategories.isEmpty
//               ? Center(child: Text('No categories available', style: TextStyle(color: Colors.white)))
//               : ListView(
//             scrollDirection: Axis.horizontal,
//             children: validCategories.map((category) {
//               final isSelected = selectedCategory == category;
//               return Padding(
//                 padding: const EdgeInsets.only(right: 8),
//                 child: ChoiceChip(
//                   label: Text(category),
//                   selected: isSelected,
//                   onSelected: (_) {
//                     setState(() {
//                       selectedCategory = category;
//                     });
//                   },
//                   labelStyle: TextStyle(
//                     color: isSelected ? Colors.black : Colors.white70,
//                   ),
//                   selectedColor: Colors.white,
//                   backgroundColor: Colors.grey[800],
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: MediaQuery.of(context).size.height / 5,
//           child: (categoryItems[selectedCategory] ?? []).isEmpty
//               ? Center(child: Text('No items in $selectedCategory', style: TextStyle(color: Colors.white)))
//               : ListView(
//             scrollDirection: Axis.horizontal,
//             children: (categoryItems[selectedCategory] ?? [])
//                 .map((item) => _buildBigContentCard(
//               item['thumbnail'],
//               contentId: item['id'],
//               title: item['movie_name'],
//             ))
//                 .toList(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPopularShowsSection() {
//     final popularItems = categoryItems.entries.expand((entry) => entry.value).take(10).toList();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Popular Shows',
//           style: GoogleFonts.roboto(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: MediaQuery.of(context).size.height / 5,
//           child: popularItems.isEmpty
//               ? Center(child: Text('No popular shows available', style: TextStyle(color: Colors.white)))
//               : ListView(
//             scrollDirection: Axis.horizontal,
//             children: popularItems
//                 .map((item) => _buildBigContentCard(
//               item['thumbnail'],
//               contentId: item['id'],
//               title: item['movie_name'],
//             ))
//                 .toList(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBigContentCard(
//       String imageUrl, {
//         double height = 220,
//         double width = 140,
//         required int contentId,
//         required String title,
//       }) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => StreamingScreen(
//                 contentId: contentId,
//                 title: title,
//               ),
//             ),
//           );
//         },
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(4),
//           child: Image.network(
//             imageUrl,
//             fit: BoxFit.cover,
//             height: MediaQuery.of(context).size.height / 6,
//             width: MediaQuery.of(context).size.width / 3 - 18,
//             errorBuilder: (context, error, stackTrace) {
//               return Center(child: Text('Image not found', style: TextStyle(color: Colors.white)));
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildgenresSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: categoryItems.entries
//           .where((entry) => entry.value.isNotEmpty)
//           .map((entry) {
//         final category = entry.key;
//         final items = entry.value;
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
//               child: Text(
//                 category,
//                 style: GoogleFonts.roboto(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height / 5,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(horizontal: 0),
//                 children: items
//                     .map((item) => _buildBigContentCard(
//                   item['thumbnail'],
//                   contentId: item['id'],
//                   title: item['movie_name'],
//                 ))
//                     .toList(),
//               ),
//             ),
//             const SizedBox(height: 10),
//           ],
//         );
//       }).toList(),
//     );
//   }
// }