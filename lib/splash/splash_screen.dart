// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import '../bottamnavbar/bottamNav_Bar.dart';
//  // Update the path as per your project structure
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = VideoPlayerController.asset('assets/splash.mp4') // Place your video here
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//
//         // Wait for video duration then navigate
//         Future.delayed(_controller.value.duration, () {
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (_) => BottomNavBarScreen()),
//           );
//         });
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _controller.value.isInitialized
//           ? Center(
//         child: AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: VideoPlayer(_controller),
//         ),
//       )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }
