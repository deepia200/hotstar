
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
import '../Dashbord/nominee_screen.dart';
import '../Dashbord/reward_screen.dart';
import '../Drawer/Popularshow.dart';
import '../Drawer/Training.dart';
import '../Drawer/nomineedetails_screen.dart';
import '../Drawer/refer&ern.dart';
import '../Drawer/schemes.dart';
import '../provider/auth_provider.dart';
import '../screens/Categories_Saceen.dart';
import '../screens/Dashboard_screen.dart';
import '../screens/KYC_screen.dart';
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
                  // _buildTile(context, Icons.search, 'Search', SearchScreen()),
                  // _buildTile(context, Icons.movie_creation_outlined, 'Movie', SearchScreen()),
                  _buildTile(context, Icons.category, 'Categories', CategoriesScreen()),
                  _buildTile(context, Icons.dashboard, 'Dashboard', DashboardScreen()),
                  _buildTile(context, Icons.person, 'My Profile', const ProfileScreen()),
                  _buildTile(context, Icons.lightbulb, 'Schemes',  const SchemeScreen()),
                  _buildTile(context, Icons.people, 'My Network', const NetworkTree()),
                  // _buildTile(context, Icons.verified_user, 'My KYC', const MyKycScreen()),
                  ListTile(
                    leading: const Icon(Icons.verified_user),
                    title: Text('My KYC', style: GoogleFonts.roboto()),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final isKycDone = prefs.getBool('kyc_done') ?? false;

                      if (isKycDone) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MyKycScreen()), // Already done
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => KycScreen(
                              username: user.fname ?? '',
                              email: user.email ?? '',
                              phone: user.phone ?? '',
                            ),
                          ),
                        );
                      }
                    },

                  ),
                  // _buildTile(context, Icons.assignment_ind, 'Nominee', const NomineeScreen()),
          ListTile(
            leading: const Icon(Icons.assignment_ind, color: Colors.white),
            title: const Text('Nominee', style: TextStyle(color: Colors.white)),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              bool nomineeFilled = prefs.getBool('nomineeFilled') ?? false;

              if (nomineeFilled) {
                final nomineeData = {
                  'nominee_name': prefs.getString('nomineeName') ?? '',
                  'relation': prefs.getString('relation') ?? '',
                  'age': prefs.getString('age') ?? '',
                  'aadhar_number': prefs.getString('aadhar') ?? '',
                  'pan_number': prefs.getString('pan') ?? '',
                  'mobile_number': prefs.getString('mobile') ?? '',
                };

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NomineeDetailsScreen(nomineeData: nomineeData),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NomineeScreen()),
                );
              }
            },
          ),
                  _buildTile(context, Icons.person_add, 'My Direct', const DirectScreen()),
                  _buildTile(context, Icons.card_giftcard, 'My Reward', const MyRewardScreen()),
                  _buildTile(context, Icons.emoji_events, 'My Award', const MyAwardScreen()),
                  _buildTile(context, Icons.attach_money, 'My Daily Income', const MyIncomeScreen()),
                  _buildTile(context, Icons.school, 'My Training', TrainingScreen()),
                  _buildTile(context, Icons.app_registration, 'Member Registration', const NewMemberRegistrationScreen()),
                  _buildTile(context, Icons.badge, 'Distributor ID Card', const KycIdCardScreen()),
                  _buildTile(context,Icons.share, 'Refer & Earn',ReferAndEarnScreen()),
                ] else ...[
                  _buildTile(context, Icons.home, 'Home', HomeScreen()),
                  _buildTile(context, Icons.category, 'Categories', CategoriesScreen()),
                  // _buildTile(context, Icons.search, 'Search', SearchScreen()),
                  _buildTile(context, Icons.person, 'My Profile', const ProfileScreen()),
                  _simpleTile(Icons.favorite, 'Favorites'),
                  // _simpleTile(Icons.subscriptions, 'Subscriptions'),
                  _buildTile(context, Icons.star, 'Popular Shows', PopularShowsScreen()),
                  _simpleTile(Icons.history, 'Recent Searches'),
                ],

                const Divider(),

                // Sign Out
                // ListTile(
                //   leading: const Icon(Icons.logout, color: Colors.red),
                //   title: Text('Sign Out', style: GoogleFonts.roboto(color: Colors.red)),
                //   onTap: () {
                //     Navigator.pushAndRemoveUntil(
                //       context,
                //       MaterialPageRoute(builder: (_) => const AuthScreen()),
                //           (route) => false,
                //     );
                //   },
                // ),
                // Show Sign Out only if user is logged in
                if (user.id != null && user.id!.isNotEmpty)
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: Text('Sign Out', style: GoogleFonts.roboto(color: Colors.red)),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear(); // clear stored login/session data

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
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Dashbord/Detail_screen.dart';
// import '../Dashbord/Kyc_screen.dart';
// import '../Dashbord/Networktree_screen.dart';
// import '../Dashbord/awrd_screen.dart';
// import '../Dashbord/destributorid_card.dart';
// import '../Dashbord/direct_screen.dart' hide MyIncomeScreen;
// import '../Dashbord/memberRagistration_screen.dart';
// import '../Dashbord/nominee_screen.dart';
// import '../Dashbord/reward_screen.dart';
// import '../provider/auth_provider.dart';
// import '../screens/Dashboard_screen.dart';
// import '../screens/KYC_screen.dart';
// import '../screens/auth_Screen.dart';
// import '../screens/edit_profile.dart';
// import '../screens/home_Screen.dart';
// import '../screens/profile_streaming.dart';
// import '../screens/search screen.dart';
//
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
//     _refreshUserDetails();
//   }
//
//   Future<void> _loadMemberType() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       memberType = prefs.getString('memberType') ?? '';
//     });
//   }
//
//   Future<void> _refreshUserDetails() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     if (authProvider.id != null) {
//       await authProvider.fetchUserDetailsById(authProvider.id!);
//     }
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
//                           backgroundImage: (user.profileImage != null &&
//                               user.profileImage!.isNotEmpty)
//                               ? NetworkImage(ApiMethods.getImageUrl(user.profileImage))
//                               : null,
//                           child: (user.profileImage == null ||
//                               user.profileImage!.isEmpty)
//                               ? const Icon(Icons.person, size: 50, color: Colors.white70)
//                               : null,
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           user.fname ?? 'Guest',
//                           style: GoogleFonts.roboto(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         if (user.email != null && user.email!.isNotEmpty)
//                           Text(
//                             user.email!,
//                             style: GoogleFonts.roboto(
//                               color: Colors.white70,
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
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
//                 // Drawer Items
//                 if (memberType == '0') ...[
//                   _buildTile(context, Icons.home, 'Home', HomeScreen()),
//                   _buildTile(context, Icons.search, 'Search', SearchScreen()),
//                   _simpleTile(Icons.category, 'Categories'),
//                   _buildTile(context, Icons.dashboard, 'Dashboard', DashboardScreen()),
//                   _buildTile(context, Icons.person, 'My Profile', const ProfileScreen()),
//                   _simpleTile(Icons.lightbulb, 'Schemes'),
//                   _buildTile(context, Icons.people, 'My Network', const NetworkTree()),
//
//                   // ✅ Conditional KYC Navigation
//                   ListTile(
//                     leading: const Icon(Icons.verified_user),
//                     title: Text('My KYC', style: GoogleFonts.roboto()),
//                     onTap: () async {
//                       final authProvider = Provider.of<AuthProvider>(context, listen: false);
//                       await authProvider.fetchUserDetailsById(authProvider.id!);
//
//                       bool isKycSubmitted = authProvider.kycStatus == '1';
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                           isKycSubmitted ? const MyKycScreen() : KycScreen(
//                             username: user.fname ?? '',
//                             email: user.email ?? '',
//                             phone: user.phone ?? '',
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//
//                   _buildTile(context, Icons.person_add, 'My Direct', const DirectScreen()),
//                   _buildTile(context, Icons.card_giftcard, 'My Reward', const NomineeScreen()),
//                   _buildTile(context, Icons.emoji_events, 'My Award', const MyAwardScreen()),
//                   _buildTile(context, Icons.attach_money, 'My Daily Income', const MyIncomeScreen()),
//                   _simpleTile(Icons.school, 'My Training'),
//                   _buildTile(context, Icons.app_registration, 'Member Registration', const NewMemberRegistrationScreen()),
//                   _buildTile(context, Icons.badge, 'Distributor ID Card', const KycIdCardScreen()),
//                   _simpleTile(Icons.share, 'Refer & Earn'),
//                 ] else ...[
//                   _buildTile(context, Icons.home, 'Home', HomeScreen()),
//                   _buildTile(context, Icons.search, 'Search', SearchScreen()),
//                   _buildTile(context, Icons.person, 'My Profile', const ProfileScreen()),
//                   _simpleTile(Icons.favorite, 'Favorites'),
//                   _simpleTile(Icons.star, 'Popular Shows'),
//                   _simpleTile(Icons.history, 'Recent Searches'),
//                 ],
//
//                 const Divider(),
//
//                 // Logout
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
//   Widget _buildTile(BuildContext context, IconData icon, String title, Widget destination) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title, style: GoogleFonts.roboto()),
//       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => destination)),
//     );
//   }
//
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
