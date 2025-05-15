import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Dashbord/Detail_screen.dart';
import '../Dashbord/Kyc_screen.dart';
import '../Dashbord/Network_screen.dart';
import '../Dashbord/awrd_screen.dart';
import '../Dashbord/destributorid_card.dart';
import '../Dashbord/direct_screen.dart';
import '../Dashbord/memberRagistration_screen.dart';
import '../Dashbord/reward_screen.dart';
import '../provider/dasshbord_provider.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardProvider>(context, listen: false).loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = Provider.of<DashboardProvider>(context);

    final List<_DashboardItem> items = [
      _DashboardItem(title: 'My Network', icon: Icons.people, destination: const NetworkScreen(), count: dashboard.networkCount),
      _DashboardItem(title: 'My KYC', icon: Icons.verified_user, destination: const MyKycScreen()),
      _DashboardItem(title: 'My Direct', icon: Icons.person_add, destination: const DirectScreen(), count: dashboard.directCount),
      _DashboardItem(title: 'My Reward', icon: Icons.card_giftcard, destination: const MyRewardScreen(), count: dashboard.rewardCount),
      _DashboardItem(title: 'My Award', icon: Icons.emoji_events, destination: const MyAwardScreen(), count: dashboard.awardCount),
      _DashboardItem(title: 'My Detail Income', icon: Icons.attach_money, destination: const MyIncomeScreen()),
      _DashboardItem(title: 'New Member Registration', icon: Icons.app_registration, destination: const NewMemberRegistrationScreen()),
      _DashboardItem(title: 'Distributor ID Card', icon: Icons.badge, destination: const KycIdCardScreen()),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Dashboard',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item.destination),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon, color: Colors.white, size: 40),
                    const SizedBox(height: 10),
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    if (item.count != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          item.count.toString(),
                          style: const TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DashboardItem {
  final String title;
  final IconData icon;
  final Widget destination;
  final int? count;

  const _DashboardItem({
    required this.title,
    required this.icon,
    required this.destination,
    this.count,
  });
}



// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// // Import your target screens here
// import '../Dashbord/Detail_screen.dart';
// import '../Dashbord/Kyc_screen.dart';
// import '../Dashbord/Network_screen.dart';
// import '../Dashbord/awrd_screen.dart';
// import '../Dashbord/destributorid_card.dart';
// import '../Dashbord/direct_screen.dart';
// import '../Dashbord/memberRagistration_screen.dart';
// import '../Dashbord/reward_screen.dart';
//
// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final List<_DashboardItem> items = [
//       _DashboardItem(title: 'My Network', icon: Icons.people, destination: const MyNetworkScreen()),
//       _DashboardItem(title: 'My KYC', icon: Icons.verified_user, destination: const MyKycScreen()),
//       _DashboardItem(title: 'My Direct', icon: Icons.person_add, destination: const MyDirectScreen()),
//       _DashboardItem(title: 'My Reward', icon: Icons.card_giftcard, destination: const MyRewardScreen()),
//       _DashboardItem(title: 'My Award', icon: Icons.emoji_events, destination: const MyAwardScreen()),
//       _DashboardItem(title: 'My Detail Income', icon: Icons.attach_money, destination: const MyIncomeScreen()),
//       _DashboardItem(title: 'New Member Registration', icon: Icons.app_registration, destination: const NewMemberRegistrationScreen()),
//       _DashboardItem(title: 'Distributor ID Card', icon: Icons.badge, destination: const KycIdCardScreen()),
//     ];
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title:  Center(child: Text('Dashboard', style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20 ),)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: GridView.builder(
//           itemCount: items.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 1,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//           ),
//           itemBuilder: (context, index) {
//             final item = items[index];
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => item.destination),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[900],
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.white24),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(item.icon, color: Colors.white, size: 40),
//                     const SizedBox(height: 10),
//                     Text(
//                       item.title,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(color: Colors.white, fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class _DashboardItem {
//   final String title;
//   final IconData icon;
//   final Widget destination;
//
//   const _DashboardItem({
//     required this.title,
//     required this.icon,
//     required this.destination,
//   });
// }
