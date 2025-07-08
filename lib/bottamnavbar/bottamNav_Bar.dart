// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:provider/provider.dart';
// // import '../screens/Dashboard_screen.dart';
// // import '../screens/home_Screen.dart';
// // import '../screens/search screen.dart';
// // import '../screens/profile_streaming.dart';
// // import '../screens/auth_screen.dart';
// // import '../provider/auth_provider.dart';
// //
// // class BottomNavBarScreen extends StatefulWidget {
// //   const BottomNavBarScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
// // }
// //
// // class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
// //   int _selectedIndex = 0;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final authProvider = Provider.of<AuthProvider>(context);
// //     final isLoggedIn = authProvider.isAuthenticated;
// //
// //     final List<Widget> screens = [
// //       const HomeScreen(),
// //       const SearchScreen(),
// //       if (isLoggedIn) const DashboardScreen(),
// //       const ProfileScreen(),
// //     ];
// //
// //     return WillPopScope(
// //       onWillPop: () async {
// //         if (_selectedIndex != 0) {
// //           setState(() {
// //             _selectedIndex = 0;
// //           });
// //           return false;
// //         } else {
// //           return await _showExitDialog();
// //         }
// //       },
// //       child: Scaffold(
// //         body: SafeArea(child: screens[_selectedIndex]),
// //         bottomNavigationBar: BottomNavigationBar(
// //           currentIndex: _selectedIndex,
// //           onTap: (index) {
// //             if (!isLoggedIn && index == screens.length - 1) {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const AuthScreen()),
// //               );
// //               return;
// //             }
// //             setState(() {
// //               _selectedIndex = index;
// //             });
// //           },
// //           type: BottomNavigationBarType.fixed,
// //           selectedItemColor: Colors.blueAccent,
// //           unselectedItemColor: Colors.grey,
// //           backgroundColor: Colors.black,
// //           items: [
// //             const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
// //             const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
// //             if (isLoggedIn)
// //               const BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
// //             const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Future<bool> _showExitDialog() async {
// //     return (await showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         backgroundColor: Colors.black,
// //         title: Text(
// //           'Are you sure?',
// //           style: GoogleFonts.roboto(color: Colors.white),
// //         ),
// //         content: Text(
// //           'Do you really want to exit the app?',
// //           style: GoogleFonts.roboto(color: Colors.white),
// //         ),
// //         actions: <Widget>[
// //           TextButton(
// //             onPressed: () => Navigator.of(context).pop(false),
// //             child: Text('No', style: GoogleFonts.roboto(color: Colors.white)),
// //           ),
// //           TextButton(
// //             onPressed: () => Navigator.of(context).pop(true),
// //             child: Text('Yes', style: GoogleFonts.roboto(color: Colors.white)),
// //           ),
// //         ],
// //       ),
// //     )) ??
// //         false;
// //   }
// // }
// //
//
// //
// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:provider/provider.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import '../screens/Dashboard_screen.dart';
// // import '../screens/home_Screen.dart';
// // import '../screens/search screen.dart';
// // import '../screens/profile_streaming.dart';
// // import '../screens/auth_screen.dart';
// // import '../provider/auth_provider.dart';
// //
// // class BottomNavBarScreen extends StatefulWidget {
// //   const BottomNavBarScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
// // }
// //
// // class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
// //   int _selectedIndex = 0;
// //   String memberType = '';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadMemberType();
// //   }
// //
// //   Future<void> _loadMemberType() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     setState(() {
// //       memberType = prefs.getString('memberType') ?? '';
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final authProvider = Provider.of<AuthProvider>(context);
// //     final isLoggedIn = authProvider.isAuthenticated;
// //     final isMember = isLoggedIn && memberType == '0';
// //
// //     final List<Widget> screens = [
// //        HomeScreen(),
// //       const SearchScreen(),
// //       if (isMember) const DashboardScreen(),
// //       const ProfileScreen(),
// //     ];
// //
// //     final List<BottomNavigationBarItem> navItems = [
// //       const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
// //       const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
// //       if (isMember)
// //         const BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
// //       const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
// //     ];
// //
// //     return WillPopScope(
// //       onWillPop: () async {
// //         if (_selectedIndex != 0) {
// //           setState(() {
// //             _selectedIndex = 0;
// //           });
// //           return false;
// //         } else {
// //           return await _showExitDialog();
// //         }
// //       },
// //       child: Scaffold(
// //         body: SafeArea(
// //           child: screens[_selectedIndex.clamp(0, screens.length - 1)],
// //         ),
// //         bottomNavigationBar: BottomNavigationBar(
// //           currentIndex: _selectedIndex.clamp(0, navItems.length - 1),
// //           onTap: (index) {
// //             // If trying to open profile and not logged in
// //             if (!isLoggedIn && index == navItems.length - 1) {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const AuthScreen()),
// //               );
// //               return;
// //             }
// //             setState(() {
// //               _selectedIndex = index;
// //             });
// //           },
// //           type: BottomNavigationBarType.fixed,
// //           selectedItemColor: Colors.blueAccent,
// //           unselectedItemColor: Colors.grey,
// //           backgroundColor: Colors.black,
// //           items: navItems,
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Future<bool> _showExitDialog() async {
// //     return (await showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         backgroundColor: Colors.black,
// //         title: Text('Are you sure?', style: GoogleFonts.roboto(color: Colors.white)),
// //         content: Text('Do you really want to exit the app?',
// //             style: GoogleFonts.roboto(color: Colors.white)),
// //         actions: <Widget>[
// //           TextButton(
// //             onPressed: () => Navigator.of(context).pop(false),
// //             child: Text('No', style: GoogleFonts.roboto(color: Colors.white)),
// //           ),
// //           TextButton(
// //             onPressed: () => Navigator.of(context).pop(true),
// //             child: Text('Yes', style: GoogleFonts.roboto(color: Colors.white)),
// //           ),
// //         ],
// //       ),
// //     )) ?? false;
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../screens/Dashboard_screen.dart';
// import '../screens/home_Screen.dart';
// import '../screens/search screen.dart';
// import '../screens/profile_streaming.dart';
// import '../screens/auth_screen.dart';
// import '../provider/auth_provider.dart';
//
// class BottomNavBarScreen extends StatefulWidget {
//   const BottomNavBarScreen({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
// }
//
// class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
//   int _selectedIndex = 0;
//   String memberType = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadMemberType();
//   }
//
//   Future<void> _loadMemberType() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       memberType = prefs.getString('memberType') ?? '';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     final isLoggedIn = authProvider.isAuthenticated;
//     final isMember = isLoggedIn && memberType == '0'; // Show Dashboard if user is member (0)
//
//     final List<Widget> screens = [
//       (isMember) ?
//         DashboardScreen() :
//         HomeScreen(),
//       //HomeScreen(),
//       const SearchScreen(),
//       if (isMember) const HomeScreen(),
//       const ProfileScreen(),
//     ];
//
//     final List<BottomNavigationBarItem> navItems = [
//       const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//       const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
//       if (isMember)
//         const BottomNavigationBarItem(icon: Icon(Icons.movie_creation_outlined), label: 'Movie'),
//       const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//     ];
//
//     return WillPopScope(
//       onWillPop: () async {
//         if (_selectedIndex != 0) {
//           setState(() {
//             _selectedIndex = 0;
//           });
//           return false;
//         } else {
//           return await _showExitDialog();
//         }
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: screens[_selectedIndex.clamp(0, screens.length - 1)],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _selectedIndex.clamp(0, navItems.length - 1),
//           onTap: (index) {
//             // If trying to open profile and not logged in
//             if (!isLoggedIn && index == navItems.length - 1) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const AuthScreen()),
//               );
//               return;
//             }
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: Colors.blueAccent,
//           unselectedItemColor: Colors.grey,
//           backgroundColor: Colors.black,
//           items: navItems,
//         ),
//       ),
//     );
//   }
//
//   Future<bool> _showExitDialog() async {
//     return (await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.black,
//         title: Text('Are you sure?', style: GoogleFonts.roboto(color: Colors.white)),
//         content: Text('Do you really want to exit the app?',
//             style: GoogleFonts.roboto(color: Colors.white)),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: Text('No', style: GoogleFonts.roboto(color: Colors.white)),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: Text('Yes', style: GoogleFonts.roboto(color: Colors.white)),
//           ),
//         ],
//       ),
//     )) ?? false;
//   }
// }
