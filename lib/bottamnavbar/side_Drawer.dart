// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
//
// import '../Dashbord/Detail_screen.dart';
// import '../Dashbord/Kyc_screen.dart';
// import '../Dashbord/Network_screen.dart';
// import '../Dashbord/awrd_screen.dart';
// import '../Dashbord/destributorid_card.dart';
// import '../Dashbord/direct_screen.dart';
// import '../Dashbord/memberRagistration_screen.dart';
// import '../Dashbord/reward_screen.dart';
// import '../provider/auth_provider.dart';
// import '../screens/auth_Screen.dart';
//
// class HotstarDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<AuthProvider>(context);
//     final mediaHeight = MediaQuery.of(context).size.height;
//
//     return Drawer(
//       child: SafeArea(
//         child: SingleChildScrollView( // Handles overflow by making it scrollable
//           child: ConstrainedBox(
//             constraints: BoxConstraints(minHeight: mediaHeight),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Container(
//                   height: mediaHeight * 0.2, // Responsive height
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.pink.shade700, Colors.blue.shade400],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                   ),
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 35,
//                           backgroundColor: Colors.white24,
//                           child: Icon(Icons.person, size: 45, color: Colors.white),
//                         ),
//                         SizedBox(height: 12),
//                         Text(
//                           user.name ?? 'Loading...',
//                           style: GoogleFonts.roboto(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           user.email ?? 'Loading...',
//                           style: GoogleFonts.roboto(
//                             color: Colors.white70,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         if (user.username != null) ...[
//                           SizedBox(height: 4),
//                           Text(
//                             'ID: ${user.username}',
//                             style: GoogleFonts.roboto(
//                               color: Colors.white70,
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Menu Items
//                 ListTile(
//                   leading: Icon(Icons.people),
//                   title: Text('My Network', style: GoogleFonts.roboto()),
//                   onTap: () => Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => NetworkScreen())),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.verified_user),
//                   title: Text('My KYC', style: GoogleFonts.roboto()),
//                   onTap: () => Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => MyKycScreen())),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.person_add),
//                   title: Text('My Direct', style: GoogleFonts.roboto()),
//                   onTap: () => Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => DirectScreen())),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.card_giftcard),
//                   title: Text('My Reward', style: GoogleFonts.roboto()),
//                   onTap: () => Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => MyRewardScreen())),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.emoji_events),
//                   title: Text('My Award', style: GoogleFonts.roboto()),
//                   onTap: () => Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => MyAwardScreen())),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.attach_money),
//                   title: Text('My Detail Income', style: GoogleFonts.roboto()),
//                   onTap: () => Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => MyIncomeScreen())),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.app_registration),
//                   title: Text('Member Registration', style: GoogleFonts.roboto()),
//                   onTap: () => Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => NewMemberRegistrationScreen())),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.badge),
//                   title: Text('Distributor ID Card', style: GoogleFonts.roboto()),
//                   onTap: () => Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => KycIdCardScreen())),
//                 ),
//
//                 Divider(),
//
//                 ListTile(
//                   leading: Icon(Icons.logout, color: Colors.red),
//                   title: Text('Sign Out', style: GoogleFonts.roboto(color: Colors.red)),
//                   onTap: () {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (_) => AuthScreen()),
//                           (route) => false,
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Dashbord/Detail_screen.dart';
// import '../Dashbord/Kyc_screen.dart';
// import '../Dashbord/Network_screen.dart';
// import '../Dashbord/awrd_screen.dart';
// import '../Dashbord/destributorid_card.dart';
// import '../Dashbord/direct_screen.dart';
// import '../Dashbord/memberRagistration_screen.dart';
// import '../Dashbord/reward_screen.dart';
// import '../provider/auth_provider.dart';
// import '../screens/Dashboard_screen.dart';
// import '../screens/auth_Screen.dart';
// import '../screens/edit_profile.dart';
// import '../screens/profile_streaming.dart';
// import '../service/api_methods.dart';
//
// class HotstarDrawer extends StatefulWidget {
//   @override
//   State<HotstarDrawer> createState() => _HotstarDrawerState();
// }
//
// class _HotstarDrawerState extends State<HotstarDrawer> {
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
//     final user = Provider.of<AuthProvider>(context);
//     final mediaHeight = MediaQuery.of(context).size.height;
//
//     return Drawer(
//       child: SafeArea(
//         child: SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(minHeight: mediaHeight),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Header
//                 Container(
//                   height: mediaHeight * 0.2,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.pink.shade700, Colors.blue.shade400],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                   ),
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 50,
//                           backgroundColor: Colors.grey[800],
//                           backgroundImage: (user.profileImage != null && user.profileImage!.isNotEmpty)
//                               ? NetworkImage(ApiMethods.getImageUrl(user.profileImage))
//                               : null,
//                           child: (user.profileImage == null || user.profileImage!.isEmpty)
//                               ? const Icon(Icons.person, size: 50, color: Colors.white70)
//                               : null,
//                         ),
//
//                         // CircleAvatar(
//                         //   radius: 35,
//                         //   backgroundColor: Colors.white24,
//                         //   child: Icon(Icons.person, size: 45, color: Colors.white),
//                         // ),
//                         const SizedBox(height: 12),
//                         Text(
//                           user.fname ?? 'Guest',
//                           style: GoogleFonts.roboto(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           user.email ?? 'guest@example.com',
//                           style: GoogleFonts.roboto(
//                             color: Colors.white70,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         if (user.id != null && memberType == "0") ...[
//                           const SizedBox(height: 4),
//                           Text(
//                             'ID: ${user.id}',
//                             style: GoogleFonts.roboto(
//                               color: Colors.white70,
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Conditional Drawer Items
//                 if (memberType == '0') ...[
//                   _buildTile(context, Icons.category, 'Categories',  EditProfileScreen()),
//                   _buildTile(context, Icons.dashboard, 'Dashboard',  DashboardScreen()),
//                   _buildTile(context, Icons.person, 'My Profile', const ProfileScreen()),
//                   _buildTile(context, Icons.lightbulb, 'Schemes',  EditProfileScreen()),
//                   _buildTile(context, Icons.people, 'My Network', const NetworkScreen()),
//
//                   _buildTile(context, Icons.verified_user, 'My KYC', const MyKycScreen()),
//                   _buildTile(context, Icons.person_add, 'My Direct', const DirectScreen()),
//                   _buildTile(context, Icons.card_giftcard, 'My Reward', const MyRewardScreen()),
//                   _buildTile(context, Icons.emoji_events, 'My Award', const MyAwardScreen()),
//                   _buildTile(context, Icons.attach_money, 'My Detail Income', const MyIncomeScreen()),
//                   _buildTile(context, Icons.school, 'My Training',  EditProfileScreen()),
//                   _buildTile(context, Icons.app_registration, 'Member Registration', const NewMemberRegistrationScreen()),
//                   _buildTile(context, Icons.badge, 'Distributor ID Card', const KycIdCardScreen()),
//                   _buildTile(context, Icons.badge, 'Refer & Earn', const KycIdCardScreen()),
//
//
//
//
//
//                 ] else ...[
//                   _simpleTile(Icons.favorite, 'Favorites'),
//                   _simpleTile(Icons.subscriptions, 'Subscriptions'),
//                   _simpleTile(Icons.star, 'Popular Shows'),
//                   _simpleTile(Icons.history, 'Recent Searches'),
//                 ],
//
//                 const Divider(),
//
//                 // Sign Out
//                 ListTile(
//                   leading: const Icon(Icons.logout, color: Colors.red),
//                   title: Text('Sign Out', style: GoogleFonts.roboto(color: Colors.red)),
//                   onTap: () {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (_) => const AuthScreen()),
//                           (route) => false,
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Member-only tile
//   Widget _buildTile(BuildContext context, IconData icon, String title, Widget destination) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title, style: GoogleFonts.roboto()),
//       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => destination)),
//     );
//   }
//
//   // Guest-only simple tile
//   Widget _simpleTile(IconData icon, String title) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title, style: GoogleFonts.roboto()),
//       onTap: () {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('$title feature coming soon!')),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashbord/Detail_screen.dart';
import '../Dashbord/Kyc_screen.dart';
import '../Dashbord/Networktree_screen.dart';
import '../Dashbord/awrd_screen.dart';
import '../Dashbord/destributorid_card.dart';
import '../Dashbord/direct_screen.dart' hide MyIncomeScreen;
import '../Dashbord/memberRagistration_screen.dart';
import '../Dashbord/reward_screen.dart';
import '../provider/auth_provider.dart';
import '../screens/Dashboard_screen.dart';
import '../screens/auth_Screen.dart';
import '../screens/edit_profile.dart';
import '../screens/home_Screen.dart';
import '../screens/profile_streaming.dart';
import '../screens/search screen.dart';
import '../service/api_methods.dart';

class HotstarDrawer extends StatefulWidget {
  @override
  State<HotstarDrawer> createState() => _HotstarDrawerState();
}

class _HotstarDrawerState extends State<HotstarDrawer> {
  String memberType = '';

  @override
  void initState() {
    super.initState();
    _loadMemberType();
  }

  Future<void> _loadMemberType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      memberType = prefs.getString('memberType') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);
    final mediaHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: mediaHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                // Container(
                //   height: mediaHeight * 0.2,
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [Colors.pink.shade700, Colors.blue.shade400],
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomRight,
                //     ),
                //   ),
                //   child: Center(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         CircleAvatar(
                //           radius: 50,
                //           backgroundColor: Colors.grey[800],
                //           backgroundImage: (user.profileImage != null && user.profileImage!.isNotEmpty)
                //               ? NetworkImage(ApiMethods.getImageUrl(user.profileImage))
                //               : null,
                //           child: (user.profileImage == null || user.profileImage!.isEmpty)
                //               ? const Icon(Icons.person, size: 50, color: Colors.white70)
                //               : null,
                //         ),
                //         const SizedBox(height: 12),
                //         Text(
                //           user.fname ?? 'Guest',
                //           style: GoogleFonts.roboto(
                //             color: Colors.white,
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         Text(
                //           user.email ?? 'guest@example.com',
                //           style: GoogleFonts.roboto(
                //             color: Colors.white70,
                //             fontSize: 14,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         if (user.id != null && memberType == "0") ...[
                //           const SizedBox(height: 4),
                //           Text(
                //             'ID: ${user.id}',
                //             style: GoogleFonts.roboto(
                //               color: Colors.white70,
                //               fontSize: 12,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ],
                //       ],
                //     ),
                //   ),
                // ),
                Container(
                  height: mediaHeight * 0.2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.pink.shade700, Colors.blue.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[800],
                          backgroundImage: (user.profileImage != null && user.profileImage!.isNotEmpty)
                              ? NetworkImage(ApiMethods.getImageUrl(user.profileImage))
                              : null,
                          child: (user.profileImage == null || user.profileImage!.isEmpty)
                              ? const Icon(Icons.person, size: 50, color: Colors.white70)
                              : null,
                        ),
                        const SizedBox(height: 12),

                        // Name
                        Text(
                          user.fname ?? 'Guest',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Email (only if available)
                        if (user.email != null && user.email!.isNotEmpty)
                          Text(
                            user.email!,
                            style: GoogleFonts.roboto(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        // ID (only if memberType is 0)
                        if (user.id != null && memberType == "0") ...[
                          const SizedBox(height: 4),
                          Text(
                            'ID: ${user.id}',
                            style: GoogleFonts.roboto(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),


                // Drawer Items
                if (memberType == '0') ...[
                  _buildTile(context, Icons.home, 'Home', HomeScreen()),
                  _buildTile(context, Icons.search, 'Search', SearchScreen()),
                  // _buildTile(context, Icons.movie_creation_outlined, 'Movie', SearchScreen()),
                  _buildTile(context, Icons.category, 'Categories', EditProfileScreen()),
                  _buildTile(context, Icons.dashboard, 'Dashboard', DashboardScreen()),
                  _buildTile(context, Icons.person, 'My Profile', const ProfileScreen()),
                  _buildTile(context, Icons.lightbulb, 'Schemes', EditProfileScreen()),
                  _buildTile(context, Icons.people, 'My Network', const NetworkTree()),
                  _buildTile(context, Icons.verified_user, 'My KYC', const MyKycScreen()),
                  _buildTile(context, Icons.person_add, 'My Direct', const DirectScreen()),
                  _buildTile(context, Icons.card_giftcard, 'My Reward', const MyRewardScreen()),
                  _buildTile(context, Icons.emoji_events, 'My Award', const MyAwardScreen()),
                  _buildTile(context, Icons.attach_money, 'My Detail Income', const MyIncomeScreen()),
                  _buildTile(context, Icons.school, 'My Training', EditProfileScreen()),
                  _buildTile(context, Icons.app_registration, 'Member Registration', const NewMemberRegistrationScreen()),
                  _buildTile(context, Icons.badge, 'Distributor ID Card', const KycIdCardScreen()),
                  _buildTile(context, Icons.share, 'Refer & Earn', const KycIdCardScreen()),
                ] else ...[
                  _buildTile(context, Icons.home, 'Home', HomeScreen()),
                  _buildTile(context, Icons.search, 'Search', SearchScreen()),
                  _buildTile(context, Icons.person, 'My Profile', const ProfileScreen()),
                  _simpleTile(Icons.favorite, 'Favorites'),
                  // _simpleTile(Icons.subscriptions, 'Subscriptions'),
                  _simpleTile(Icons.star, 'Popular Shows'),
                  _simpleTile(Icons.history, 'Recent Searches'),
                ],

                const Divider(),

                // Sign Out
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: Text('Sign Out', style: GoogleFonts.roboto(color: Colors.red)),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const AuthScreen()),
                          (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, IconData icon, String title, Widget destination) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: GoogleFonts.roboto()),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => destination)),
    );
  }

  Widget _simpleTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: GoogleFonts.roboto()),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title feature coming soon!')),
        );
      },
    );
  }
}
