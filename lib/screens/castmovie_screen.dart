// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../service/api_service.dart';
// import 'streaming_screen.dart'; // Import your screen
// //
// // class CastMoviesScreen extends StatelessWidget {
// //   final String actorName;
// //
// //   const CastMoviesScreen({super.key, required this.actorName});
// //
// //   List<Map<String, String>> getMockMovies() {
// //     return [
// //       {
// //         'title': 'Ramayan',
// //         'release_date': '1987',
// //         'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3TGnuUWH8H2rj48nsBUUPDrgrBQKHpyguCg&s',
// //       },
// //       {
// //         'title': 'Luv Kush',
// //         'release_date': '1989',
// //         'image': 'https://www.tvtime.com/_next/image?url=https%3A%2F%2Fartworks.thetvdb.com%2Fbanners%2Fv4%2Fseries%2F309259%2Fposters%2F614384858e577.jpg&w=640&q=75',
// //       },
// //       {
// //         'title': 'Vikram Aur Betaal',
// //         'release_date': '1985',
// //         'image': 'https://i.pinimg.com/736x/f9/03/fa/f903fafdf7da0adb883bee0fa54ff863.jpg',
// //       },
// //       {
// //         'title': 'Shree Krishna',
// //         'release_date': '1993',
// //         'image': 'https://m.media-amazon.com/images/M/MV5BMWU1OTliM2YtM2I3OS00NTlmLTk4YmQtYWI0ODRiMWZlNGExXkEyXkFqcGc@._V1_.jpg',
// //       },
// //       {
// //         'title': 'Mahabharat',
// //         'release_date': '1988',
// //         'image': 'https://m.media-amazon.com/images/M/MV5BYzM1MmNhMGQtNDliNy00ZDIwLTg1MDQtN2NjZjUyNTg2MGMxXkEyXkFqcGc@._V1_QL75_UX190_CR0,13,190,281_.jpg',
// //       },
// //       {
// //         'title': 'Bharat Ek Khoj',
// //         'release_date': '1988',
// //         'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoM6v-ZoScuBFutrVjlriPIW2UL2fBlLBGs-j08QySVJDvT1AXxCXsIG-Mygne_yY2840&usqp=CAU',
// //       },
// //     ];
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final movies = getMockMovies();
// //     final screenWidth = MediaQuery.of(context).size.width;
// //     final imageHeight = MediaQuery.of(context).size.height * 0.2 - 42;
// //
// //     return SafeArea(
// //       child: Scaffold(
// //         backgroundColor: Colors.black,
// //         appBar: AppBar(
// //           title: Text(
// //             '$actorName Movies',
// //             style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),
// //           ),
// //           centerTitle: true,
// //           backgroundColor: Colors.black,
// //         ),
// //         body: GridView.builder(
// //           padding: const EdgeInsets.all(12),
// //           itemCount: movies.length,
// //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //             crossAxisCount: 3,
// //             crossAxisSpacing: 11,
// //             mainAxisSpacing: 13,
// //             childAspectRatio: 0.6,
// //           ),
// //           itemBuilder: (context, index) {
// //             final movie = movies[index];
// //             return GestureDetector(
// //               onTap: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (_) => StreamingScreen(),
// //                   ),
// //                 );
// //               },
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   color: Colors.grey.withOpacity(0.2),
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   children: [
// //                     ClipRRect(
// //                       borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
// //                       child: Image.network(
// //                         movie['image']!,
// //                         height: imageHeight,
// //                         width: screenWidth,
// //                         fit: BoxFit.fill,
// //                       ),
// //                     ),
// //                     Padding(
// //                       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
// //                       child: Column(
// //                         children: [
// //                           Text(
// //                             movie['title']!,
// //                             style: const TextStyle(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 13,
// //                             ),
// //                             maxLines: 2,
// //                             textAlign: TextAlign.center,
// //                             overflow: TextOverflow.ellipsis,
// //                           ),
// //                         // SizedBox(height: 2),
// //                           Text(
// //                             'Year: ${movie['release_date']}',
// //                             style: const TextStyle(color: Colors.white70, fontSize: 11),
// //                             textAlign: TextAlign.center,
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// class CastMoviesScreen extends StatelessWidget {
//   final String actorName;
//
//   const CastMoviesScreen({super.key, required this.actorName});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final imageHeight = MediaQuery.of(context).size.height * 0.2 - 42;
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           title: Text(
//             '$actorName Movies',
//             style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.black,
//         ),
//         body: FutureBuilder<Map<String, dynamic>?>(
//           future: ApiService.getcastData(actorName),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError || snapshot.data == null) {
//               return const Center(
//                 child: Text(
//                   'Failed to load movies',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               );
//             } else if (snapshot.data!['movies'] == null || snapshot.data!['movies'].isEmpty) {
//               return const Center(
//                 child: Text(
//                   'No movies found for this actor',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               );
//             }
//
//             final movies = snapshot.data!['movies'] as List<dynamic>;
//
//             return GridView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: movies.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 11,
//                 mainAxisSpacing: 13,
//                 childAspectRatio: 0.6,
//               ),
//               itemBuilder: (context, index) {
//                 final movie = movies[index] as Map<String, dynamic>;
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => StreamingScreen(),
//                       ),
//
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//                           child: Image.network(
//                             '${ApiService.baseUrl}/${movie['thumbnail']}',
//                             height: imageHeight,
//                             width: screenWidth,
//                             fit: BoxFit.fill,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Container(
//                                 height: imageHeight,
//                                 width: screenWidth,
//                                 color: Colors.grey[800],
//                                 child: const Icon(Icons.broken_image, color: Colors.white70),
//                               );
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
//                           child: Column(
//                             children: [
//                               Text(
//                                 movie['movie_name'],
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 13,
//                                 ),
//                                 maxLines: 2,
//                                 textAlign: TextAlign.center,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               Text(
//                                 'Year: ${movie['release_year']}',
//                                 style: const TextStyle(color: Colors.white70, fontSize: 11),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../service/api_service.dart';
import 'streaming_screen.dart';

class CastMoviesScreen extends StatelessWidget {
  final String actorName;

  const CastMoviesScreen({super.key, required this.actorName});

  static const String _imageBaseUrl = 'https://stag.aanandi.in/reel_life_otts/storage/app/public/';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = MediaQuery.of(context).size.height * 0.2 - 42;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            '$actorName Movies',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: FutureBuilder<Map<String, dynamic>?>(
          future: ApiService.getcastData(actorName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Center(
                child: Text(
                  'Failed to load movies',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            } else if (snapshot.data!['movies'] == null || snapshot.data!['movies'].isEmpty) {
              return const Center(
                child: Text(
                  'No movies found for this actor',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }

            final movies = snapshot.data!['movies'] as List<dynamic>;

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 11,
                mainAxisSpacing: 13,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                final movie = movies[index] as Map<String, dynamic>;
                final imageUrl = movie['thumbnail'] != null && movie['thumbnail'].isNotEmpty
                    ? '$_imageBaseUrl${movie['thumbnail']}'
                    : '$_imageBaseUrl/placeholder.jpg';
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StreamingScreen(
                          contentId: movie['content_id'] ?? 0,
                          title: movie['movie_name'] ?? 'No Title',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                          child: Image.network(
                            imageUrl,
                            height: imageHeight,
                            width: screenWidth,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: imageHeight,
                                width: screenWidth,
                                color: Colors.grey[800],
                                child: const Icon(Icons.broken_image, color: Colors.white70),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          child: Column(
                            children: [
                              Text(
                                movie['movie_name'] ?? 'No Title',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Year: ${movie['release_year'] ?? 'N/A'}',
                                style: const TextStyle(color: Colors.white70, fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}