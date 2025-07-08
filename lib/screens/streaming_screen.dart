// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../provider/auth_provider.dart';
// import 'Details_Screen.dart';
// import 'auth_Screen.dart';
// import 'home_Screen.dart';
//
// class StreamingScreen extends StatelessWidget {
//   const StreamingScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
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
//                 children: [
//                   // Vimeo Video using WebView with Autoplay
//                   SizedBox(
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height / 4,
//
//
//                     child: WebViewWidget(
//                       controller: WebViewController()
//                         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//                         ..loadRequest(
//                           Uri.parse(
//                             'https://player.vimeo.com/video/1077793352?autoplay=1&muted=1',
//                           ),
//                         ),
//                     ),
//                   ),
//                    // IconButton(
//                    //   padding: EdgeInsets.only(left: 20),
//                    //     onPressed: (){
//                    //       Navigator.pop(context);
//                    //     },
//                    //     icon:Icon( Icons.arrow_back,
//                    //     color: Colors.white,
//                    //     size: 30,))// Add Back Button or Overlay if needed
//                 ],
//               ),
//
//
//               // Title and Info
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Ramayan',
//                       style: GoogleFonts.roboto(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'Drama • Hindi • 1987',
//                       style: GoogleFonts.roboto(fontSize: 12, color: Colors.blue),
//                     ),
//                     const SizedBox(height: 10),
//
//                     // Watch Now + Share Row
//                     Row(
//                       children: [
//                         // Full width "Watch Now" button
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               final authProvider = Provider.of<AuthProvider>(context, listen: false);
//
//                               if (authProvider.isAuthenticated) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const EpisodeDetailsScreen(title: "Ramayan"),
//                                   ),
//                                 );
//                               } else {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const AuthScreen(),
//                                   ),
//                                 );
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               padding: EdgeInsets.zero,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               backgroundColor: Colors.transparent,
//                               elevation: 4,
//                             ),
//                             child: Ink(
//                               decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   colors: [Color(0xFF2196F3), Color(0xFFE91E63)],
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                 ),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 constraints: const BoxConstraints(minHeight: 40),
//                                 child: const Text(
//                                   'Watch Now',
//                                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(width: 12),
//
//                         // Share icon
//                         IconButton(
//                           icon: Icon(Icons.share, color: Colors.white),
//                           onPressed: () {
//                             Share.share('Check out this awesome content!');
//                           },
//                         )
//                       ],
//                     ),
//
//                     const SizedBox(height: 20),
//                     Text(
//                       'Ramayan is an iconic Indian television series based on the ancient Sanskrit epic. '
//                           'Created by Ramanand Sagar, it originally aired in 1987 and depicts the life of Lord Rama, '
//                           'his exile, the abduction of his wife Sita by Ravana, and the eventual victory of good over evil. '
//                           'The show is revered for its cultural impact and remains a landmark in Indian television history.',
//                       style: GoogleFonts.roboto(color: Colors.white, fontSize: 14, height: 1.5),
//                     ),
//
//
//
//                     const SizedBox(height: 10),
//                     Text(
//                       'Cast Details:',
//                       style: GoogleFonts.roboto(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '• Arun Govil as Ram\n'
//                           '• Deepika Chikhalia as Sita\n'
//                           '• Dara Singh as Hanuman\n'
//                           '• Sunil Lahri as Lakshman',
//                       style: GoogleFonts.roboto(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Related Shows
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Related Shows',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     GestureDetector(
//                       onTap: (){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (_) => const StreamingScreen()),
//                         );
//                       },
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height / 6,
//
//                         child: ListView(
//                           scrollDirection: Axis.horizontal,
//                           physics: const BouncingScrollPhysics(), // Optional smooth scroll
//                           children: [
//                             relatedShowCard(context,
//                               'https://m.media-amazon.com/images/M/MV5BZmNjMzliYjgtNDdkNC00ZWU5LWI1ZDAtNGI2ODNjODUzMTc1XkEyXkFqcGc@._V1_QL75_UY207_CR8,0,140,207_.jpg',
//                             ),
//                             relatedShowCard(context,
//                               'https://akamaividz2.zee5.com/image/upload/w_756,h_1134,c_scale,f_webp,q_auto:eco/resources/0-6-300/portrait/1920x7701558563901558563909e660834d6014e26bb303fb89dc5b3aa.jpg',
//                             ),
//                             relatedShowCard(context,
//                               'https://www.tvtime.com/_next/image?url=https%3A%2F%2Fartworks.thetvdb.com%2Fbanners%2Fv4%2Fseries%2F309259%2Fposters%2F614384858e577.jpg&w=640&q=75',
//                             ),
//                             relatedShowCard(context,
//                               'https://www.tvtime.com/_next/image?url=https%3A%2F%2Fartworks.thetvdb.com%2Fbanners%2Fv4%2Fseries%2F309259%2Fposters%2F614384858e577.jpg&w=640&q=75',
//                             ),
//                             relatedShowCard(context,
//                               'https://www.tvtime.com/_next/image?url=https%3A%2F%2Fartworks.thetvdb.com%2Fbanners%2Fv4%2Fseries%2F309259%2Fposters%2F614384858e577.jpg&w=640&q=75',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget relatedShowCard(BuildContext context, String imageUrl) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: Image.network(
//           imageUrl,
//           width: MediaQuery.of(context).size.width / 4,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
//
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../provider/auth_provider.dart';
// import '../service/api_service.dart';
// import 'Details_Screen.dart';
// import 'auth_Screen.dart';
// import 'castmovie_screen.dart';
// import 'home_Screen.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class StreamingScreen extends StatefulWidget {
//   const StreamingScreen({Key? key}) : super(key: key);
//
//   @override
//   _StreamingScreenState createState() => _StreamingScreenState();
// }
//
// class _StreamingScreenState extends State<StreamingScreen> {
//   List<dynamic> contentList = [];
//   bool isLoading = true;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     fetchContent();
//   }
//
//   Future<void> fetchContent() async {
//     try {
//       final response = await ApiService.fetchContent();
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           contentList = data['data'];
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//           errorMessage = 'Failed to load content: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Error fetching content: $e';
//       });
//     }
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: ShaderMask(
//           shaderCallback:
//               (bounds) => LinearGradient(
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
//       body: SafeArea(
//         child:
//         isLoading
//             ? Center(child: CircularProgressIndicator())
//             : errorMessage.isNotEmpty
//             ? Center(
//           child: Text(
//             errorMessage,
//             style: TextStyle(color: Colors.white),
//           ),
//         )
//             : SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Display the first item as featured content
//               if (contentList.isNotEmpty)
//                 _buildFeaturedContent(contentList[0]),
//
//               // Display the rest of the content
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'More Content',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     // Replace GridView.builder with horizontal ListView.builder
//                     SizedBox(
//                       height: 240,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: contentList.length,
//                         itemBuilder: (context, index) {
//                           final content = contentList[index];
//                           return Padding(
//                             padding: const EdgeInsets.only(right: 12),
//                             child: _buildContentCard(content),
//                           );
//                         },
//                       ),
//                     ),
//
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
//   Widget _buildFeaturedContent(Map<String, dynamic> content) {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             SizedBox(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height / 4,
//               // child: WebViewWidget(
//               //   controller:
//               //   WebViewController()
//               //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//               //     ..loadRequest(
//               //       Uri.parse(
//               //         'https://player.vimeo.com/video/1077793352?autoplay=1&muted=1',
//               //       ),
//               //     ),
//               // ),
//               child: WebViewWidget(
//                 controller: WebViewController()
//                   ..setJavaScriptMode(JavaScriptMode.unrestricted)
//                   ..loadRequest(
//                     Uri.parse(content['full_video_url'] ?? 'https://example.com'),
//                   ),
//               )
//               ,
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 content['movie_name'] ?? 'No Title',
//                 style: GoogleFonts.roboto(
//                   fontSize: 24,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '${content['content_type'] ?? 'Content'} • ${content['release_year']?.substring(0, 4) ?? 'Year'}',
//                 style: GoogleFonts.roboto(fontSize: 12, color: Colors.blue),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       // onPressed: () {
//                       //   final authProvider = Provider.of<AuthProvider>(context, listen: false);
//                       //   if (authProvider.isAuthenticated) {
//                       //     Navigator.push(
//                       //       context,
//                       //       MaterialPageRoute(
//                       //         builder: (context) => EpisodeDetailsScreen(
//                       //           title: "Sample Title", // Fallback title if API fails
//                       //           contentId: 1, // The ID of the content to fetch
//                       //         ),
//                       //       ),
//                       //     );
//                       //   } else {
//                       //     Navigator.push(
//                       //       context,
//                       //       MaterialPageRoute(
//                       //         builder: (context) => const AuthScreen(),
//                       //       ),
//                       //     );
//                       //   }
//                       // },
//                       onPressed: () {
//                         final authProvider = Provider.of<AuthProvider>(
//                           context,
//                           listen: false,
//                         );
//
//                         if (authProvider.isAuthenticated) {
//                           showModalBottomSheet(
//                             context: context,
//                             backgroundColor: Colors.grey[900],
//                             isScrollControlled:
//                             true, // important for full visibility
//                             shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(20),
//                               ),
//                             ),
//                             builder: (BuildContext context) {
//                               return SafeArea(
//                                 child: SingleChildScrollView(
//                                   padding: EdgeInsets.only(
//                                     bottom:
//                                     MediaQuery.of(
//                                       context,
//                                     ).viewInsets.bottom +
//                                         20,
//                                     top: 20,
//                                     left: 20,
//                                     right: 20,
//                                   ),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       const Icon(
//                                         Icons.lock_open_rounded,
//                                         size: 40,
//                                         color: Colors.white,
//                                       ),
//                                       const SizedBox(height: 12),
//                                       const Text(
//                                         'Pay ₹30 to Continue',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 10),
//                                       const Text(
//                                         'To continue watching this content, please pay ₹30.',
//                                         style: TextStyle(color: Colors.white70),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                       const SizedBox(height: 6),
//                                       const Text(
//                                         'You can watch this movie for 24 hours.',
//                                         style: TextStyle(
//                                           color: Colors.lightGreenAccent,
//                                           fontSize: 13,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                       const SizedBox(height: 24),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: OutlinedButton(
//                                               style: OutlinedButton.styleFrom(
//                                                 side: const BorderSide(
//                                                   color: Colors.white70,
//                                                 ),
//                                                 minimumSize:
//                                                 const Size.fromHeight(
//                                                   50,
//                                                 ), // increased height
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                   BorderRadius.zero,
//                                                 ),
//                                               ),
//                                               onPressed:
//                                                   () => Navigator.pop(context),
//                                               child: Text(
//                                                 'Cancel',
//                                                 style: GoogleFonts.roboto(
//                                                   color: Colors.white70,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(width: 10),
//                                           Expanded(
//                                             child: ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.green,
//                                                 minimumSize:
//                                                 const Size.fromHeight(
//                                                   50,
//                                                 ), // increased height
//                                                 shape:
//                                                 const RoundedRectangleBorder(
//                                                   borderRadius:
//                                                   BorderRadius.zero,
//                                                 ),
//                                               ),
//                                               onPressed: () {
//                                                 Navigator.pop(
//                                                   context,
//                                                 ); // Close bottom sheet
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) => EpisodeDetailsScreen(
//                                                       title: content['movie_name'],
//                                                       contentId: content['content_id'], // ✅ Pass the dynamic content_id
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                               child: Text(
//                                                 'Pay ₹30',
//                                                 style: GoogleFonts.roboto(
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         } else {
//                           // If not authenticated
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const AuthScreen(),
//                             ),
//                           );
//                         }
//                       },
//
//                       style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.zero,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         backgroundColor: Colors.transparent,
//                         elevation: 4,
//                       ),
//                       child: Ink(
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [Color(0xFF2196F3), Color(0xFFE91E63)],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Container(
//                           alignment: Alignment.center,
//                           constraints: const BoxConstraints(minHeight: 40),
//                           child: const Text(
//                             'Watch Now',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   IconButton(
//                     icon: Icon(Icons.share, color: Colors.white),
//                     onPressed: () {
//                       Share.share('Check out ${content['movie_name']} on ReelLife!');
//                     },
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 20),
//
//               // 👇 Cast Section Inserted Here
//
//               buildCastGrid(),
//
//               const SizedBox(height: 20),
//               Text(
//                 content['description'] ?? 'No description available',
//                 style: GoogleFonts.roboto(
//                   color: Colors.white,
//                   fontSize: 14,
//                   height: 1.5,
//                 ),
//               ),
//             ],
//           ),
//         ),
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
//             builder: (context) => EpisodeDetailsScreen(
//               title: content['movie_name'],
//               contentId: content['content_id'], // ✅ Pass the dynamic content_id
//             ),
//           ),
//         );
//       },
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height / 2,
//         width: MediaQuery.of(context).size.width / 1,
//         child: Card(
//           color: Colors.grey[900],
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(
//                         'https://stag.aanandi.in/reel_life_otts/public/${content['thumbnail']}',
//                       ),
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
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
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
//
//         ),
//       ),
//
//     );
//   }
//
//   Widget buildCastGrid() {
//     // Sample cast data - replace with your actual cast data from API
//     final List<Map<String, String>> castMembers = [
//       {'name': 'Arun Govil', 'role': 'Ram', 'image': ''},
//       {'name': 'Deepika Chikhalia', 'role': 'Sita', 'image': ''},
//       {'name': 'Sunil Lahri', 'role': 'Laxman', 'image': ''},
//       {'name': 'Dara Singh', 'role': 'Hanuman', 'image': ''},
//       {'name': 'Arvind Trivedi', 'role': 'Ravan', 'image': ''},
//       {'name': 'Vijay Arora', 'role': 'Indrajit', 'image': ''},
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Cast',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 12),
//         SizedBox(
//           height: 140, // Fixed height for the cast row
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: castMembers.length,
//             itemBuilder: (context, index) {
//               final member = castMembers[index];
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => CastMoviesScreen(actorName: member['name']!),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 100, // Fixed width for each cast member
//                   margin: EdgeInsets.only(right: 16),
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 40,
//                         backgroundColor: Colors.grey[800],
//                         child: Icon(Icons.person, size: 40, color: Colors.white70),
//                         // Replace with actual image when available:
//                         // backgroundImage: member['image'] != null
//                         //   ? NetworkImage(member['image']!)
//                         //   : null,
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         member['role']!,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         member['name']!,
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 12,
//                         ),
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
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../provider/auth_provider.dart';
// import '../service/api_service.dart';
// import 'Details_Screen.dart';
// import 'auth_Screen.dart';
// import 'castmovie_screen.dart';
//
// import 'dart:convert';
//
// class StreamingScreen extends StatefulWidget {
//   const StreamingScreen({Key? key}) : super(key: key);
//
//   @override
//   _StreamingScreenState createState() => _StreamingScreenState();
// }
//
// class _StreamingScreenState extends State<StreamingScreen> {
//   List<dynamic> contentList = [];
//   bool isLoading = true;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     fetchContent();
//   }
//
//   Future<void> fetchContent() async {
//     try {
//       final response = await ApiService.fetchContent();
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           contentList = data['data'];
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//           errorMessage = 'Failed to load content: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Error fetching content: $e';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: ShaderMask(
//           shaderCallback: (bounds) =>
//               const LinearGradient(
//                 colors: [Colors.blue, Colors.pink],
//                 tileMode: TileMode.mirror,
//               ).createShader(bounds),
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
//       body: SafeArea(
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : errorMessage.isNotEmpty
//             ? Center(
//           child: Text(
//             errorMessage,
//             style: const TextStyle(color: Colors.white),
//           ),
//         )
//             : SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (contentList.isNotEmpty)
//                 _buildFeaturedContent(contentList[0]),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'More Content',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     SizedBox(
//                       height: 240,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: contentList.length,
//                         itemBuilder: (context, index) {
//                           final content = contentList[index];
//                           return Padding(
//                             padding:
//                             const EdgeInsets.only(right: 12.0),
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
//
//   Widget _buildFeaturedContent(Map<String, dynamic> content) {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             SizedBox(
//               width: double.infinity,
//               height: MediaQuery
//                   .of(context)
//                   .size
//                   .height / 4,
//               child: WebViewWidget(
//                 controller: WebViewController()
//                   ..setJavaScriptMode(JavaScriptMode.unrestricted)
//                   ..loadRequest(
//                     Uri.parse(
//                         content['full_video_url'] ?? 'https://example.com'),
//                   ),
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 content['movie_name'] ?? 'No Title',
//                 style: GoogleFonts.roboto(
//                   fontSize: 24,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '${content['content_type'] ??
//                     'Content'} • ${content['release_year'] ?? 'Year'}',
//                 style: GoogleFonts.roboto(fontSize: 12, color: Colors.blue),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         final authProvider =
//                         Provider.of<AuthProvider>(context, listen: false);
//                         if (authProvider.isAuthenticated) {
//                           showModalBottomSheet(
//                             context: context,
//                             backgroundColor: Colors.grey[900],
//                             isScrollControlled: true,
//                             shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(20),
//                               ),
//                             ),
//                             builder: (BuildContext context) {
//                               return SafeArea(
//                                 child: SingleChildScrollView(
//                                   padding: EdgeInsets.only(
//                                     bottom:
//                                     MediaQuery
//                                         .of(context)
//                                         .viewInsets
//                                         .bottom + 20,
//                                     top: 20,
//                                     left: 20,
//                                     right: 20,
//                                   ),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       const Icon(
//                                         Icons.lock_open_rounded,
//                                         size: 40,
//                                         color: Colors.white,
//                                       ),
//                                       const SizedBox(height: 12),
//                                       const Text(
//                                         'Pay ₹30 to Continue',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 10),
//                                       const Text(
//                                         'To continue watching this content, please pay ₹30.',
//                                         style: TextStyle(color: Colors.white70),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                       const SizedBox(height: 6),
//                                       const Text(
//                                         'You can watch this movie for 24 hours.',
//                                         style: TextStyle(
//                                           color: Colors.lightGreenAccent,
//                                           fontSize: 13,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                       const SizedBox(height: 24),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: OutlinedButton(
//                                               style: OutlinedButton.styleFrom(
//                                                 side: const BorderSide(
//                                                   color: Colors.white70,
//                                                 ),
//                                                 minimumSize: const Size
//                                                     .fromHeight(50),
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius: BorderRadius
//                                                       .zero,
//                                                 ),
//                                               ),
//                                               onPressed: () =>
//                                                   Navigator.pop(context),
//                                               child: Text(
//                                                 'Cancel',
//                                                 style: GoogleFonts.roboto(
//                                                   color: Colors.white70,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(width: 10),
//                                           Expanded(
//                                             child: ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.green,
//                                                 minimumSize: const Size
//                                                     .fromHeight(50),
//                                                 shape: const RoundedRectangleBorder(
//                                                   borderRadius: BorderRadius
//                                                       .zero,
//                                                 ),
//                                               ),
//                                               onPressed: () {
//                                                 Navigator.pop(context);
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         EpisodeDetailsScreen(
//                                                           title: content['movie_name'],
//                                                           contentId: content['id'],
//                                                         ),
//                                                   ),
//                                                 );
//                                               },
//                                               child: Text(
//                                                 'Pay ₹30',
//                                                 style: GoogleFonts.roboto(
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         } else {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const AuthScreen(),
//                             ),
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.zero,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         backgroundColor: Colors.transparent,
//                         elevation: 4,
//                       ),
//                       child: Ink(
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [Color(0xFF2196F3), Color(0xFFE91E63)],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Container(
//                           alignment: Alignment.center,
//                           constraints: const BoxConstraints(minHeight: 40),
//                           child: const Text(
//                             'Watch Now',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   IconButton(
//                     icon: const Icon(Icons.share, color: Colors.white),
//                     onPressed: () {
//                       Share.share(
//                           'Check out ${content['movie_name']} on ReelLife!');
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               buildCastGrid(content),
//               const SizedBox(height: 20),
//               Text(
//                 content['description'] ?? 'No description available',
//                 style: GoogleFonts.roboto(
//                   color: Colors.white,
//                   fontSize: 14,
//                   height: 1.5,
//                 ),
//               ),
//             ],
//           ),
//         ),
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
//             builder: (context) =>
//                 EpisodeDetailsScreen(
//                   title: content['movie_name'],
//                   contentId: content['id'] ?? 0,
//                 ),
//           ),
//         );
//       },
//       child: SizedBox(
//         width: 140,
//         child: Card(
//           color: Colors.grey[900],
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(
//                         'https://stag.aanandi.in/reel_life_otts/public/${content['thumbnail']}',
//                       ),
//                       fit: BoxFit.cover,
//                     ),
//                     borderRadius: const BorderRadius.vertical(
//                         top: Radius.circular(12)),
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
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Text(
//                       '${content['genre_name'] ??
//                           'Genre'} • ${content['duration'] ?? '0'} min',
//                       style: const TextStyle(
//                           color: Colors.white70, fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//
//         ),
//       ),
//     );
//   }
//
// //   Widget buildCastGrid(Map<String, dynamic> content) {
// //     List<String>? castNames = (content['cast_names'] as String?)?.split(',');
// //     List<String>? castRoles = (content['role_names'] as String?)?.split(',');
// //     List<String>? castImages =
// //     (content['cast_profile_photos'] as String?)?.split(',');
// //
// //     if (castNames == null || castNames.isEmpty) return const SizedBox();
// //
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text(
// //           'Cast',
// //           style: TextStyle(
// //             color: Colors.white,
// //             fontSize: 18,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         const SizedBox(height: 12),
// //         SizedBox(
// //           height: 140,
// //           child: ListView.builder(
// //             scrollDirection: Axis.horizontal,
// //             itemCount: castNames.length,
// //             itemBuilder: (context, index) {
// //               return GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (_) => CastMoviesScreen(actorName: castNames[index]),
// //                     ),
// //                   );
// //                 },
// //                 child: Container(
// //                   width: 100,
// //                   margin: const EdgeInsets.only(right: 16),
// //                   child: Column(
// //                     children: [
// //                       CircleAvatar(
// //                         radius: 40,
// //                         backgroundColor: Colors.grey[800],
// //                         backgroundImage: castImages != null && castImages[index].isNotEmpty
// //                             ? NetworkImage('https://stag.aanandi.in/reel_life_otts/public/${castImages[index]}')
// //                             : null,
// //                         child: castImages == null || castImages[index].isEmpty
// //                             ? const Icon(Icons.person, size: 40, color: Colors.white70)
// //                             : null,
// //                       ),
// //                       const SizedBox(height: 8),
// //                       Text(
// //                         castRoles?[index] ?? '',
// //                         style: const TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 14,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                         textAlign: TextAlign.center,
// //                         maxLines: 1,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       Text(
// //                         castNames[index],
// //                         style: const TextStyle(
// //                           color: Colors.white70,
// //                           fontSize: 12,
// //                         ),
// //                         textAlign: TextAlign.center,
// //                         maxLines: 1,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
//   Widget buildCastGrid(Map<String, dynamic> content) {
//     List<String>? castNames = (content['cast_names'] as String?)?.split(',');
//     List<String>? castRoles = (content['role_names'] as String?)?.split(',');
//     List<String>? castImages = (content['cast_profile_photos'] as String?)
//         ?.split(',');
//
//     // Default fallback cast list if API returns null or empty
//     final List<Map<String, String>> fallbackCast = [
//       {'name': 'Arun Govil', 'role': 'Ram', 'image': ''},
//       {'name': 'Deepika Chikhalia', 'role': 'Sita', 'image': ''},
//       {'name': 'Sunil Lahri', 'role': 'Laxman', 'image': ''},
//       {'name': 'Dara Singh', 'role': 'Hanuman', 'image': ''},
//       {'name': 'Arvind Trivedi', 'role': 'Ravan', 'image': ''},
//       {'name': 'Vijay Arora', 'role': 'Indrajit', 'image': ''},
//     ];
//
//     final bool hasValidApiCast = castNames != null && castNames.isNotEmpty;
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
//             itemCount: hasValidApiCast ? castNames.length : fallbackCast.length,
//             itemBuilder: (context, index) {
//               final name = hasValidApiCast
//                   ? castNames[index]
//                   : fallbackCast[index]['name']!;
//               final role = hasValidApiCast
//                   ? (castRoles?[index] ?? '')
//                   : fallbackCast[index]['role']!;
//               final imageUrl = hasValidApiCast
//                   ? (castImages != null && castImages[index].isNotEmpty
//                   ? 'https://stag.aanandi.in/reel_life_otts/public/${castImages[index]}'
//                   : '')
//                   : fallbackCast[index]['image']!;
//
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => CastMoviesScreen(actorName: name),
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
//                         backgroundImage: imageUrl.isNotEmpty ? NetworkImage(
//                             imageUrl) : null,
//                         child: imageUrl.isEmpty
//                             ? const Icon(Icons.person, size: 40, color: Colors
//                             .white70)
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
//                         style: const TextStyle(
//                           color: Colors.white70,
//                           fontSize: 12,
//                         ),
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
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../provider/auth_provider.dart';
import '../service/api_service.dart';
import 'Details_Screen.dart';
import 'Wallet_sacreen.dart';
import 'auth_Screen.dart';
import 'castmovie_screen.dart';
import 'dart:convert';

class StreamingScreen extends StatefulWidget {
  final int? contentId;
  final String? title;

  const StreamingScreen({Key? key, this.contentId, this.title})
    : super(key: key);

  Future<bool> isMemberUser() async {
    final prefs = await SharedPreferences.getInstance();
    final memberType = prefs.getString('memberType') ?? '';
    return memberType == '0';
  }

  @override
  _StreamingScreenState createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  static const String _imageBaseUrl =
      'https://stag.aanandi.in/reel_life_otts/storage/app/public/';
  List<dynamic> contentList = [];
  Map<String, dynamic>? selectedContent;
  bool isLoading = true;
  String errorMessage = '';
  bool showAllCast = false; // Moved showAllCast to class level

  @override
  void initState() {
    super.initState();
    fetchContent();
  }

  Future<void> fetchContent() async {
    try {
      if (widget.contentId != null) {
        final response = await ApiService.fetchContentById(widget.contentId!);
        print("deep");
        print(response.body);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            selectedContent = data['data'];
            // Ensure thumbnail URL is complete
            if (selectedContent != null &&
                selectedContent!['thumbnail'] != null) {
              selectedContent!['thumbnail'] =
                  '$_imageBaseUrl${selectedContent!['thumbnail']}';
            }
            contentList = [selectedContent];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            errorMessage = 'Failed to load content: ${response.statusCode}';
          });
        }
      } else {
        final response = await ApiService.fetchContent();
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            contentList =
                (data['data'] as List).map((item) {
                  if (item['thumbnail'] != null) {
                    item['thumbnail'] = '$_imageBaseUrl${item['thumbnail']}';
                  }
                  return item;
                }).toList();
            selectedContent = contentList.isNotEmpty ? contentList[0] : null;
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            errorMessage = 'Failed to load content: ${response.statusCode}';
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching content: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback:
              (bounds) => const LinearGradient(
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
              if (isMember) {
                return IconButton(
                  icon: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WalletScreen(),
                      ),
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
      body: SafeArea(
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                ? Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (selectedContent != null)
                        _buildFeaturedContent(selectedContent!),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'More Content',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 240,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: contentList.length,
                                itemBuilder: (context, index) {
                                  final content = contentList[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: _buildContentCard(content),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget _buildFeaturedContent(Map<String, dynamic> content) {
    // Format rent_amount, default to '30' if null
    final rentAmount = content['rent_amount']?.toString() ?? '30';
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              child: WebViewWidget(
                controller:
                    WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..loadRequest(
                        Uri.parse(
                          content['full_video_url'] ?? 'https://example.com',
                        ),
                      ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content['movie_name'] ?? widget.title ?? 'No Title',
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${content['genre_name'] ?? 'Content'} • ${content['release_year'] ?? 'Year'}',
                style: GoogleFonts.roboto(fontSize: 12, color: Colors.blue),
              ),
              const SizedBox(height: 8),
              // Text(
              //   'Rent: ₹$rentAmount',
              //   style: GoogleFonts.roboto(
              //     fontSize: 16,
              //     color: Colors.white70,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.grey[900],
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return SafeArea(
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom +
                                      20,
                                  top: 20,
                                  left: 20,
                                  right: 20,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.lock_open_rounded,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Pay ₹$rentAmount to Continue',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'To continue watching this content, please pay ₹$rentAmount.',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'You can watch this movie for 24 hours.',
                                      style: TextStyle(
                                        color: Colors.lightGreenAccent,
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                color: Colors.white70,
                                              ),
                                              minimumSize:
                                                  const Size.fromHeight(50),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              ),
                                            ),
                                            onPressed:
                                                () => Navigator.pop(context),
                                            child: Text(
                                              'Cancel',
                                              style: GoogleFonts.roboto(
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              minimumSize:
                                                  const Size.fromHeight(50),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.zero,
                                                  ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);

                                              final authProvider =
                                                  Provider.of<AuthProvider>(
                                                    context,
                                                    listen: false,
                                                  );
                                              if (authProvider
                                                  .isAuthenticated) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (
                                                          context,
                                                        ) => EpisodeDetailsScreen(
                                                          title:
                                                              content['movie_name'] ??
                                                              widget.title,
                                                          contentId:
                                                              content['id'] ??
                                                              widget
                                                                  .contentId ??
                                                              0,
                                                        ),
                                                  ),
                                                );
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (_) =>
                                                            const AuthScreen(),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Text(
                                              'Pay ₹$rentAmount',
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 4,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2196F3), Color(0xFFE91E63)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(minHeight: 40),
                          child: const Text(
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
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.white),
                    onPressed: () {
                      Share.share(
                        'Check out ${content['movie_name'] ?? widget.title} on ReelLife!',
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              buildCastGrid(content),
              const SizedBox(height: 20),
              Text(
                content['description'] ?? 'No description available',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContentCard(Map<String, dynamic> content) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => StreamingScreen(
                  contentId: content['id'] ?? 0,
                  title: content['movie_name'],
                ),
          ),
        );
      },
      child: SizedBox(
        width: 140,
        child: Card(
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        content['thumbnail'] ??
                            '$_imageBaseUrl/placeholder.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content['movie_name'] ?? 'No Title',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${content['genre_namegenre_name'] ?? 'Genre'} • ${content['duration'] ?? '0'} min',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCastGrid(Map<String, dynamic> content) {
    List<String>? castNames = (content['cast_names'] as String?)?.split(',');
    List<String>? castRoles = (content['role_names'] as String?)?.split(',');
    List<String>? castImages = (content['cast_profile_photos'] as String?)
        ?.split(',');

    if (castNames == null || castNames.isEmpty) {
      return const SizedBox();
    }

    final itemCount =
        showAllCast
            ? castNames.length
            : (castNames.length > 4 ? 4 : castNames.length);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cast',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final name = castNames[index];
              final role =
                  castRoles != null && index < castRoles.length
                      ? castRoles[index]
                      : '';
              final imageUrl =
                  castImages != null &&
                          index < castImages.length &&
                          castImages[index].isNotEmpty
                      ? '$_imageBaseUrl${castImages[index]}'
                      : '';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CastMoviesScreen(actorName: name),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[800],
                        backgroundImage:
                            imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                        child:
                            imageUrl.isEmpty
                                ? const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white70,
                                )
                                : null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        role,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (castNames.length > 4) ...[
          TextButton(
            onPressed: () {
              setState(() {
                showAllCast = !showAllCast;
              });
            },
            child: Text(
              showAllCast ? 'Show Less' : 'Show More',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ],
    );
  }
}
