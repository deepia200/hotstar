// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../provider/episode_provider.dart';
//
// class EpisodeDetailsScreen extends StatefulWidget {
//   final String title;
//
//   const EpisodeDetailsScreen({Key? key, required this.title, required Map<String, dynamic> content}) : super(key: key);
//
//   @override
//   State<EpisodeDetailsScreen> createState() => _EpisodeDetailsScreenState();
// }
//
// class _EpisodeDetailsScreenState extends State<EpisodeDetailsScreen> {
//   Widget buildEpisodeTile(Episode episode) {
//     return ListTile(
//       leading: Image.network(
//         'https://i.ytimg.com/vi/Ei8oBTxHZcU/hq720.jpg',
//         width: 100,
//         fit: BoxFit.cover,
//       ),
//       title: Text(
//         episode.title,
//         style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
//       ),
//       subtitle: Text(
//         '${episode.subtitle} • ${episode.duration}',
//         style: const TextStyle(color: Colors.grey),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final episodeProvider = Provider.of<EpisodeProvider>(context);
//     final episodes = episodeProvider.episodes;
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar( title: ShaderMask(
//         shaderCallback:
//             (bounds) => LinearGradient(
//           colors: [Colors.blue, Colors.pink],
//           tileMode: TileMode.mirror,
//         ).createShader(bounds),
//         child: Text(
//           'ReelLife',
//           style: GoogleFonts.roboto(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         elevation: 0,),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                children: [
//                  SizedBox(
//                    width: double.infinity,
//                    height: MediaQuery.of(context).size.height / 4,
//                    child: WebViewWidget(
//                      controller: WebViewController()
//                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
//                        ..loadRequest(Uri.parse('https://player.vimeo.com/video/1077793352?autoplay=1&muted=1')),
//                    ),
//                  ),
//                  // IconButton(
//                  //     padding: EdgeInsets.only(left: 20),
//                  //     onPressed: (){
//                  //       Navigator.pop(context);
//                  //     },
//                  //     icon:Icon( Icons.arrow_back,
//                  //       color: Colors.white,
//                  //       size: 30,)),
//
//                ],
//               ),
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   widget.title,
//                   style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Text(
//                   'Ramayan is an iconic Indian television series based on the ancient Sanskrit epic. '
//                       'Created by Ramanand Sagar, it originally aired in 1987 and depicts the life of Lord Rama.',
//                   style: GoogleFonts.roboto(color: Colors.white70, fontSize: 14, height: 1.5),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ...episodes.map(buildEpisodeTile).toList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../provider/episode_provider.dart';
// import '../service/api_service.dart';
// import 'castmovie_screen.dart';
//
// class EpisodeDetailsScreen extends StatefulWidget {
//   final String title;
//   final int contentId;
//
//   const EpisodeDetailsScreen({
//     Key? key,
//     required this.title,
//     required this.contentId,
//   }) : super(key: key);
//
//   @override
//   State<EpisodeDetailsScreen> createState() => _EpisodeDetailsScreenState();
// }
//
// class _EpisodeDetailsScreenState extends State<EpisodeDetailsScreen> {
//   Map<String, dynamic>? contentDetails;
//   bool isLoading = true;
//   String errorMessage = '';
//   bool showAllCast = false;
//   bool showFullDescription = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchContentDetails();
//   }
//
//   Future<void> fetchContentDetails() async {
//     try {
//       final response = await ApiService.fetchContentDetails(widget.contentId.toString());
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           contentDetails = data['data'];
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//           errorMessage = 'Failed to load content details: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Error fetching content details: $e';
//       });
//     }
//   }
//
//
//   Widget buildRatingSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             // Icon(Icons.star, color: Colors.amber, size: 20),
//             // SizedBox(width: 4),
//             // Text(
//             //   contentDetails?['rating_avg'] ?? '0.0',
//             //   style: TextStyle(color: Colors.white, fontSize: 16),
//             // ),
//             // SizedBox(width: 16),
//             Icon(Icons.movie, color: Colors.blue, size: 20),
//             SizedBox(width: 4),
//             Text(
//               contentDetails?['content_type'] ?? 'Movie',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ],
//         ),
//         SizedBox(height: 8),
//         Row(
//           children: [
//             Icon(Icons.calendar_today, color: Colors.green, size: 20),
//             SizedBox(width: 4),
//             Text(
//               contentDetails?['release_year'] ?? 'N/A',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget buildCastGrid(Map<String, dynamic> content) {
//     List<String>? castNames = (content['cast_names'] as String?)?.split(',');
//     List<String>? castRoles = (content['role_names'] as String?)?.split(',');
//     List<String>? castImages = (content['cast_profile_photos'] as String?)?.split(',');
//
//     if (castNames == null || castNames.isEmpty) {
//       return const SizedBox(); // No cast to show
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Cast',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 140,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: castNames.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 width: 100,
//                 margin: const EdgeInsets.only(right: 16),
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 40,
//                       backgroundColor: Colors.grey[800],
//                       backgroundImage: castImages != null && castImages[index].isNotEmpty
//                           ? NetworkImage('https://stag.aanandi.in/reel_life_otts/public/${castImages[index]}')
//                           : null,
//                       child: castImages == null || castImages[index].isEmpty
//                           ? const Icon(Icons.person, size: 40, color: Colors.white70)
//                           : null,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       castRoles?[index] ?? '',
//                       style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Text(
//                       castNames[index],
//                       style: const TextStyle(color: Colors.white70, fontSize: 12),
//                       textAlign: TextAlign.center,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//
//
//   Widget buildDescription() {
//     final description = contentDetails?['description'] ?? 'No description available';
//     final lineCount = description.split('\n').length;
//     final isLongDescription = lineCount > 4 || description.length > 200;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 20,),
//         Text(
//           'Description',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 10),
//         Text(
//           description,
//           style: GoogleFonts.roboto(
//             color: Colors.white70,
//             fontSize: 14,
//             height: 1.5,
//           ),
//           maxLines: showFullDescription ? null : 4,
//           overflow: showFullDescription ? null : TextOverflow.ellipsis,
//         ),
//         if (isLongDescription) ...[
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 showFullDescription = !showFullDescription;
//               });
//             },
//             child: Text(
//               showFullDescription ? 'See Less' : 'See More',
//               style: TextStyle(color: Colors.blue),
//             ),
//           ),
//         ],
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final episodeProvider = Provider.of<EpisodeProvider>(context);
//     final episodes = episodeProvider.episodes;
//
//     return Scaffold(
//       backgroundColor: Colors.black,
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
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//           ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.white)))
//           : SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   SizedBox(
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height / 4,
//                     // child:
//                     child: WebViewWidget(
//               controller: WebViewController()
//             ..setJavaScriptMode(JavaScriptMode.unrestricted)
//             ..loadRequest(
//               Uri.parse(contentDetails!['trailer_url'] ?? 'https://example.com'),
//             ),
//         ),
//
//
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       contentDetails?['title'] ?? widget.title,
//                       style: const TextStyle(
//                           fontSize: 22,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 12),
//                     buildRatingSection(),
//                     SizedBox(height: 20),
//                     buildCastGrid(contentDetails!),
//
//                     // SizedBox(height: 20),
//                     // if (episodes.isNotEmpty) ...[
//                     //   Text(
//                     //     'Episodes',
//                     //     style: TextStyle(
//                     //       color: Colors.white,
//                     //       fontSize: 18,
//                     //       fontWeight: FontWeight.bold,
//                     //     ),
//                     //   ),
//                     //   SizedBox(height: 12),
//                     //   Column(
//                     //     children: episodes.map((episode) => ListTile(
//                     //       leading: Image.network(
//                     //         'https://i.ytimg.com/vi/Ei8oBTxHZcU/hq720.jpg',
//                     //         width: 100,
//                     //         fit: BoxFit.cover,
//                     //       ),
//                     //       title: Text(
//                     //         episode.title,
//                     //         style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
//                     //       ),
//                     //       subtitle: Text(
//                     //         '${episode.subtitle} • ${episode.duration}',
//                     //         style: TextStyle(color: Colors.grey),
//                     //       ),
//                     //     )).toList(),
//                     //   ),
//                     //   SizedBox(height: 20),
//                     // ],
//                     buildDescription(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }


//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hotstar/screens/streaming_screen.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../provider/episode_provider.dart';
// import '../service/api_service.dart';
// import 'Wallet_sacreen.dart';
// import 'castmovie_screen.dart';
//
// class EpisodeDetailsScreen extends StatefulWidget {
//
//   Future<bool> isMemberUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final memberType = prefs.getString('memberType') ?? '';
//     return memberType == '0';
//   }
//   final String title;
//   final int contentId;
//
//   const EpisodeDetailsScreen({
//
//     Key? key,
//     required this.title,
//     required this.contentId,
//   }) : super(key: key);
//
//
//   @override
//   State<EpisodeDetailsScreen> createState() => _EpisodeDetailsScreenState();
// }
//
// class _EpisodeDetailsScreenState extends State<EpisodeDetailsScreen> {
//   static const String _imageBaseUrl = 'https://stag.aanandi.in/reel_life_otts/storage/app/public/';
//   List<dynamic> contentList = [];
//   Map<String, dynamic>? contentDetails;
//   bool isLoading = true;
//   String errorMessage = '';
//   bool showAllCast = false;
//   bool showFullDescription = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchContentDetails();
//   }
//
//   Future<void> fetchContentDetails() async {
//     try {
//       final response = await ApiService.fetchContentDetails(widget.contentId.toString());
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           contentDetails = data['data'];
//           if (contentDetails != null && contentDetails!['thumbnail'] != null) {
//             contentDetails!['thumbnail'] = '$_imageBaseUrl${contentDetails!['thumbnail']}';
//           }
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//           errorMessage = 'Failed to load content details: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Error fetching content details: $e';
//       });
//     }
//   }
//
//   Widget buildRatingSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Icon(Icons.movie, color: Colors.blue, size: 20),
//             SizedBox(width: 4),
//             Text(
//               contentDetails?['genre_name'] ?? 'Movie',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ],
//         ),
//         SizedBox(height: 8),
//         Row(
//           children: [
//             Icon(Icons.calendar_today, color: Colors.green, size: 20),
//             SizedBox(width: 4),
//             Text(
//               contentDetails?['release_year']?.toString() ?? 'N/A',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//
//
//     // Fallback cast if API data is empty
//   Widget buildCastGrid(Map<String, dynamic> content) {
//     List<String>? castNames = (content['cast_names'] as String?)?.split(',');
//     List<String>? castRoles = (content['role_names'] as String?)?.split(',');
//     List<String>? castImages = (content['cast_profile_photos'] as String?)?.split(',');
//
//     if (castNames == null || castNames.isEmpty) {
//       return const SizedBox();
//     }
//
//     final itemCount = showAllCast ? castNames.length : (castNames.length > 4 ? 4 : castNames.length);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Cast',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 140,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: itemCount,
//             itemBuilder: (context, index) {
//               final name = castNames[index];
//               final role = castRoles != null && index < castRoles.length ? castRoles[index] : '';
//               final imageUrl = castImages != null && index < castImages.length && castImages[index].isNotEmpty
//                   ? '$_imageBaseUrl${castImages[index]}'
//                   : '';
//
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => CastMoviesScreen(actorName: 'Zoya'),
//                     ),
//                   );
//
//                 },
//                 child: Container(
//                   width: 100,
//                   margin: const EdgeInsets.only(right: 16),
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 40,
//                         backgroundColor: Colors.grey[800],
//                         backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
//                         child: imageUrl.isEmpty
//                             ? const Icon(Icons.person, size: 40, color: Colors.white70)
//                             : null,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         role,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         name,
//                         style: const TextStyle(color: Colors.white70, fontSize: 12),
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         if (castNames.length > 4) ...[
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 showAllCast = !showAllCast;
//               });
//             },
//             child: Text(
//               showAllCast ? 'Show Less' : 'Show More',
//               style: TextStyle(color: Colors.blue),
//             ),
//           ),
//         ],
//       ],
//     );
//   }
//
//
//
//
//   Widget buildDescription() {
//     final description = contentDetails?['description'] ?? 'No description available';
//     final lineCount = description.split('\n').length;
//     final isLongDescription = lineCount > 4 || description.length > 200;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 20),
//         Text(
//           'Description',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 10),
//         Text(
//           description,
//           style: GoogleFonts.roboto(
//             color: Colors.white70,
//             fontSize: 14,
//             height: 1.5,
//           ),
//           maxLines: showFullDescription ? null : 4,
//           overflow: showFullDescription ? null : TextOverflow.ellipsis,
//         ),
//         if (isLongDescription) ...[
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 showFullDescription = !showFullDescription;
//               });
//             },
//             child: Text(
//               showFullDescription ? 'See Less' : 'See More',
//               style: TextStyle(color: Colors.blue),
//             ),
//           ),
//         ],
//       ],
//     );
//   }
//   Widget _buildContentCard(Map<String, dynamic> content) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => StreamingScreen(
//               contentId: content['id'] ?? 0,
//               title: content['movie_name'],
//             ),
//           ),
//         );
//       },
//       child: SizedBox(
//         width: 140,
//         child: Card(
//           color: Colors.grey[900],
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(content['thumbnail'] ?? '$_imageBaseUrl/placeholder.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       content['movie_name'] ?? 'No Title',
//                       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Text(
//                       '${content['genre_namegenre_name'] ?? 'Genre'} • ${content['duration'] ?? '0'} min',
//                       style: const TextStyle(color: Colors.white70, fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
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
//         actions: [
//           FutureBuilder<bool>(
//             future: widget.isMemberUser(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return SizedBox.shrink();
//               }
//               final isMember = snapshot.data ?? false;
//               if (isMember) {
//                 return IconButton(
//                   icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const WalletScreen()),
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
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//           ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.white)))
//           : SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   SizedBox(
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height / 4,
//                     child: WebViewWidget(
//                       controller: WebViewController()
//                         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//                         ..loadRequest(
//                           Uri.parse(contentDetails?['trailer_url'] ?? 'https://example.com'),
//                         ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       contentDetails?['movie_name'] ?? widget.title,
//                       style: const TextStyle(
//                         fontSize: 22,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     buildRatingSection(),
//                     SizedBox(height: 20),
//                     buildCastGrid(contentDetails!),
//                     SizedBox(height: 20),
//
//                     buildDescription(),
//                     const SizedBox(height: 10),
//                     SizedBox(
//                       height: 240,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: contentList.length,
//                         itemBuilder: (context, index) {
//                           final content = contentList[index];
//                           return Padding(
//                             padding: const EdgeInsets.only(right: 12.0),
//                             child: _buildContentCard(content),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hotstar/screens/streaming_screen.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../provider/episode_provider.dart';
// import '../service/api_service.dart';
// import 'Wallet_sacreen.dart';
// import 'castmovie_screen.dart';
//
// class EpisodeDetailsScreen extends StatefulWidget {
//   Future<bool> isMemberUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final memberType = prefs.getString('memberType') ?? '';
//     return memberType == '0';
//   }
//
//   final String title;
//   final int contentId;
//
//   const EpisodeDetailsScreen({
//     Key? key,
//     required this.title,
//     required this.contentId,
//   }) : super(key: key);
//
//   @override
//   State<EpisodeDetailsScreen> createState() => _EpisodeDetailsScreenState();
// }
//
// class _EpisodeDetailsScreenState extends State<EpisodeDetailsScreen> {
//   static const String _imageBaseUrl = 'https://stag.aanandi.in/reel_life_otts/storage/app/public/';
//   List<dynamic> contentList = [];
//   Map<String, dynamic>? contentDetails;
//   bool isLoading = true;
//   bool isLoadingMoreContent = true; // Added for More Content
//   String errorMessage = '';
//   String errorMoreContent = ''; // Added for More Content
//   bool showAllCast = false;
//   bool showFullDescription = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchContentDetails();
//     fetchMoreContent(); // Fetch More Content
//   }
//
//   Future<void> fetchContentDetails() async {
//     try {
//       final response = await ApiService.fetchContentDetails(widget.contentId.toString());
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           contentDetails = data['data'];
//           if (contentDetails != null && contentDetails!['thumbnail'] != null) {
//             contentDetails!['thumbnail'] = '$_imageBaseUrl${contentDetails!['thumbnail']}';
//           }
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//           errorMessage = 'Failed to load content details: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Error fetching content details: $e';
//       });
//     }
//   }
//
//   Future<void> fetchMoreContent() async {
//     try {
//       // Replace with ApiService.fetchRelatedContent if available
//       final response = await http.get(
//         Uri.parse('https://stag.aanandi.in/reel_life_otts/public/api/ott/content/popular'),
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'success') {
//           setState(() {
//             contentList = (data['most_popular_content'] ?? [])
//                 .where((item) => item['id'] != widget.contentId) // Exclude current content
//                 .toList()
//               ..sort((a, b) => (b['watch_count'] as int).compareTo(a['watch_count'] as int))
//               ..take(10); // Limit to top 10
//             isLoadingMoreContent = false;
//           });
//         } else {
//           setState(() {
//             errorMoreContent = 'Failed to load more content';
//             isLoadingMoreContent = false;
//           });
//         }
//       } else {
//         setState(() {
//           errorMoreContent = 'Error: ${response.statusCode}';
//           isLoadingMoreContent = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMoreContent = 'Error fetching more content: $e';
//         isLoadingMoreContent = false;
//       });
//     }
//   }
//
//   Widget buildRatingSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//
//             // Icon(Icons.movie, color: Colors.blue, size: 20),
//
//             Text(
//               contentDetails?['genre_name'] ?? 'Movie',
//               style: TextStyle(color: Colors.blue, fontSize: 16),
//             ),
//             Text(" . ", style: TextStyle(color: Colors.blue, fontSize: 16),),
//             Text(
//               contentDetails?['release_year']?.toString() ?? 'N/A',
//               style: TextStyle(color: Colors.blue, fontSize: 16),
//             ),
//           ],
//         ),
//         // SizedBox(height: 8),
//         // Row(
//         //   children: [
//         //     Icon(Icons.calendar_today, color: Colors.green, size: 20),
//         //     SizedBox(width: 4),
//         //     Text(
//         //       contentDetails?['release_year']?.toString() ?? 'N/A',
//         //       style: TextStyle(color: Colors.white, fontSize: 16),
//         //     ),
//         //   ],
//         // ),
//       ],
//     );
//   }
//
//   Widget buildCastGrid(Map<String, dynamic> content) {
//     List<String>? castNames = (content['cast_names'] as String?)?.split(',');
//     List<String>? castRoles = (content['role_names'] as String?)?.split(',');
//     List<String>? castImages = (content['cast_profile_photos'] as String?)?.split(',');
//
//     if (castNames == null || castNames.isEmpty) {
//       return const SizedBox();
//     }
//
//     final itemCount = showAllCast ? castNames.length : (castNames.length > 4 ? 4 : castNames.length);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Cast',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 140,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: itemCount,
//             itemBuilder: (context, index) {
//               final name = castNames[index];
//               final role = castRoles != null && index < castRoles.length ? castRoles[index] : '';
//               final imageUrl = castImages != null && index < castImages.length && castImages[index].isNotEmpty
//                   ? '$_imageBaseUrl${castImages[index]}'
//                   : '';
//
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => CastMoviesScreen(actorName: name), // Use dynamic name
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 100,
//                   margin: const EdgeInsets.only(right: 16),
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 40,
//                         backgroundColor: Colors.grey[800],
//                         backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
//                         child: imageUrl.isEmpty
//                             ? const Icon(Icons.person, size: 40, color: Colors.white70)
//                             : null,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         role,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         name,
//                         style: const TextStyle(color: Colors.white70, fontSize: 12),
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         if (castNames.length > 4) ...[
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 showAllCast = !showAllCast;
//               });
//             },
//             child: Text(
//               showAllCast ? 'Show Less' : 'Show More',
//               style: TextStyle(color: Colors.blue),
//             ),
//           ),
//         ],
//       ],
//     );
//   }
//
//   Widget buildDescription() {
//     final description = contentDetails?['description'] ?? 'No description available';
//     final lineCount = description.split('\n').length;
//     final isLongDescription = lineCount > 4 || description.length > 200;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 20),
//         Text(
//           'Description',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 10),
//         Text(
//           description,
//           style: GoogleFonts.roboto(
//             color: Colors.white70,
//             fontSize: 14,
//             height: 1.5,
//           ),
//           maxLines: showFullDescription ? null : 4,
//           overflow: showFullDescription ? null : TextOverflow.ellipsis,
//         ),
//         if (isLongDescription) ...[
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 showFullDescription = !showFullDescription;
//               });
//             },
//             child: Text(
//               showFullDescription ? 'See Less' : 'See More',
//               style: TextStyle(color: Colors.blue),
//             ),
//           ),
//         ],
//       ],
//     );
//   }
//
//   Widget _buildContentCard(Map<String, dynamic> content) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => StreamingScreen(
//               contentId: content['id'] ?? 0,
//               title: content['movie_name'],
//             ),
//           ),
//         );
//       },
//       child: SizedBox(
//         width: 140,
//         child: Card(
//           color: Colors.grey[900],
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(content['thumbnail']?.startsWith('http')
//                           ? content['thumbnail']
//                           : '$_imageBaseUrl${content['thumbnail'] ?? 'placeholder.jpg'}'),
//                       fit: BoxFit.cover,
//                     ),
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       content['movie_name'] ?? 'No Title',
//                       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Text(
//                       '${content['genre_name'] ?? 'Genre'} • ${content['duration'] ?? '0'} min',
//                       style: const TextStyle(color: Colors.white70, fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMoreContentSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric( vertical: 8.0),
//           child: Text(
//             'More Content',
//             style: GoogleFonts.roboto(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 240,
//           child: isLoadingMoreContent
//               ? Center(child: CircularProgressIndicator())
//               : errorMoreContent.isNotEmpty
//               ? Center(child: Text(errorMoreContent, style: TextStyle(color: Colors.white)))
//               : contentList.isEmpty
//               ? Center(child: Text('No more content available', style: TextStyle(color: Colors.white)))
//               : ListView.builder(
//             scrollDirection: Axis.horizontal,
//             // padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             itemCount: contentList.length,
//             itemBuilder: (context, index) {
//               final content = contentList[index];
//               return Padding(
//                 padding: const EdgeInsets.only(right: 12.0),
//                 child: _buildContentCard(content),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
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
//         actions: [
//           FutureBuilder<bool>(
//             future: widget.isMemberUser(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return SizedBox.shrink();
//               }
//               final isMember = snapshot.data ?? false;
//               if (isMember) {
//                 return IconButton(
//                   icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const WalletScreen()),
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
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//           ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.white)))
//           : SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   SizedBox(
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height / 4,
//                     child: WebViewWidget(
//                       controller: WebViewController()
//                         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//                         ..loadRequest(
//                           Uri.parse(contentDetails?['trailer_url'] ?? 'https://example.com'),
//                         ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       contentDetails?['movie_name'] ?? widget.title,
//                       style: const TextStyle(
//                         fontSize: 22,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     buildRatingSection(),
//                     // SizedBox(height: 20),
//                     if (contentDetails?['cast_names'] != null) buildCastGrid(contentDetails!),
//                     // SizedBox(height: 20),
//                     buildDescription(),
//                     SizedBox(height: 20),
//                     if (!isLoadingMoreContent && errorMoreContent.isEmpty && contentList.isNotEmpty)
//                       _buildMoreContentSection(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotstar/screens/streaming_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../provider/episode_provider.dart';
import '../service/api_service.dart';
import 'Wallet_sacreen.dart';
import 'castmovie_screen.dart';

class EpisodeDetailsScreen extends StatefulWidget {
  Future<bool> isMemberUser() async {
    final prefs = await SharedPreferences.getInstance();
    final memberType = prefs.getString('memberType') ?? '';
    return memberType == '0';
  }

  final String title;
  final int contentId;

  const EpisodeDetailsScreen({
    Key? key,
    required this.title,
    required this.contentId,
  }) : super(key: key);

  @override
  State<EpisodeDetailsScreen> createState() => _EpisodeDetailsScreenState();
}

class _EpisodeDetailsScreenState extends State<EpisodeDetailsScreen> {
  static const String _imageBaseUrl = 'https://stag.aanandi.in/reel_life_otts/storage/app/public/';
  List<dynamic> contentList = [];
  Map<String, dynamic>? contentDetails;
  bool isLoading = true;
  bool isLoadingMoreContent = true;
  String errorMessage = '';
  String errorMoreContent = '';
  bool showAllCast = false;
  bool showFullDescription = false;

  @override
  void initState() {
    super.initState();
    fetchContentDetails();
    fetchMoreContent();
  }

  Future<void> fetchContentDetails() async {
    try {
      final response = await ApiService.fetchContentDetails(widget.contentId.toString());
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          contentDetails = data['data'];
          if (contentDetails != null && contentDetails!['thumbnail'] != null) {
            contentDetails!['thumbnail'] = '$_imageBaseUrl${contentDetails!['thumbnail']}';
          }
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load content details: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching content details: $e';
      });
    }
  }

  Future<void> fetchMoreContent() async {
    try {
      final response = await http.get(
        Uri.parse('https://stag.aanandi.in/reel_life_otts/public/api/ott/content/popular'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            contentList = (data['most_popular_content'] ?? [])
                .where((item) => item['id'] != widget.contentId)
                .toList();
            isLoadingMoreContent = false;
          });
        } else {
          setState(() {
            errorMoreContent = 'Failed to load more content';
            isLoadingMoreContent = false;
          });
        }
      } else {
        setState(() {
          errorMoreContent = 'Error: ${response.statusCode}';
          isLoadingMoreContent = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMoreContent = 'Error fetching more content: $e';
        isLoadingMoreContent = false;
      });
    }
  }

  Widget buildRatingSection() {
    return Row(
      children: [
        Text(
          contentDetails?['genre_name'] ?? 'Movie',
          style: const TextStyle(color: Colors.blue, fontSize: 14),
        ),
        const SizedBox(width: 6),
        const Text("|", style: TextStyle(color: Colors.blue, fontSize: 14)),
        const SizedBox(width: 6),
        Text(
          contentDetails?['release_year']?.toString() ?? 'N/A',
          style: const TextStyle(color: Colors.blue, fontSize: 14),
        ),
      ],
    );
  }

  Widget buildCastGrid(Map<String, dynamic> content) {
    List<String>? castNames = (content['cast_names'] as String?)?.split(',');
    List<String>? castRoles = (content['role_names'] as String?)?.split(',');
    List<String>? castImages = (content['cast_profile_photos'] as String?)?.split(',');

    if (castNames == null || castNames.isEmpty) return const SizedBox();

    final itemCount = showAllCast ? castNames.length : (castNames.length > 4 ? 4 : castNames.length);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cast', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final name = castNames[index];
              final role = castRoles != null && index < castRoles.length ? castRoles[index] : '';
              final imageUrl = castImages != null && index < castImages.length && castImages[index].isNotEmpty
                  ? '$_imageBaseUrl${castImages[index]}'
                  : '';

              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CastMoviesScreen(actorName: name))),
                child: Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[800],
                        backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                        child: imageUrl.isEmpty ? const Icon(Icons.person, size: 40, color: Colors.white70) : null,
                      ),
                      const SizedBox(height: 8),
                      Text(role, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(name, style: const TextStyle(color: Colors.white70, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (castNames.length > 4)
          TextButton(
            onPressed: () => setState(() => showAllCast = !showAllCast),
            child: Text(showAllCast ? 'Show Less' : 'Show More', style: const TextStyle(color: Colors.blue)),
          ),
      ],
    );
  }

  Widget buildDescription() {
    final description = contentDetails?['description'] ?? 'No description available';
    final isLongDescription = description.length > 200 || description.split('\n').length > 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text('Description', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
          description,
          style: GoogleFonts.roboto(color: Colors.white70, fontSize: 14, height: 1.5),
          maxLines: showFullDescription ? null : 4,
          overflow: showFullDescription ? null : TextOverflow.ellipsis,
        ),
        if (isLongDescription)
          TextButton(
            onPressed: () => setState(() => showFullDescription = !showFullDescription),
            child: Text(showFullDescription ? 'See Less' : 'See More', style: const TextStyle(color: Colors.blue)),
          ),
      ],
    );
  }

  Widget _buildContentCard(Map<String, dynamic> content) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (_) => StreamingScreen(contentId: content['id'] ?? 0, title: content['movie_name']),
      )),
      child: SizedBox(
        width: 140,
        child: Card(
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(content['thumbnail']?.startsWith('http')
                          ? content['thumbnail']
                          : '$_imageBaseUrl${content['thumbnail'] ?? 'placeholder.jpg'}'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(content['movie_name'] ?? 'No Title', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text('${content['genre_name'] ?? 'Genre'} • ${content['duration'] ?? '0'} min', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoreContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('More Content', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 240,
          child: isLoadingMoreContent
              ? const Center(child: CircularProgressIndicator())
              : errorMoreContent.isNotEmpty
              ? Center(child: Text(errorMoreContent, style: const TextStyle(color: Colors.white)))
              : contentList.isEmpty
              ? const Center(child: Text('No more content available', style: TextStyle(color: Colors.white)))
              : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: contentList.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: _buildContentCard(contentList[index]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(colors: [Colors.blue, Colors.pink]).createShader(bounds),
          child: Text('ReelLife', style: GoogleFonts.roboto(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        actions: [
          FutureBuilder<bool>(
            future: widget.isMemberUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done || !(snapshot.data ?? false)) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen())),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () => Share.share('Check out this awesome content!'),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage, style: const TextStyle(color: Colors.white)))
          : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                child: WebViewWidget(
                  controller: WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..loadRequest(Uri.parse(contentDetails?['trailer_url'] ?? 'https://example.com')),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contentDetails?['movie_name'] ?? widget.title, style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    buildRatingSection(),
                    if (contentDetails?['cast_names'] != null) buildCastGrid(contentDetails!),
                    buildDescription(),
                    const SizedBox(height: 10),
                    if (!isLoadingMoreContent && errorMoreContent.isEmpty && contentList.isNotEmpty)
                      _buildMoreContentSection(),
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
