import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashbord/Detail_screen.dart';
import '../Dashbord/Kyc_screen.dart';
import '../Dashbord/Networktree_screen.dart';
import '../Dashbord/awrd_screen.dart';
import '../Dashbord/destributorid_card.dart';
import '../Dashbord/direct_screen.dart' hide MyIncomeScreen;
import '../Dashbord/memberRagistration_screen.dart';
import '../Dashbord/myNetwork_screen.dart';
import '../Dashbord/reward_screen.dart';
import '../bottamnavbar/side_Drawer.dart';
import '../provider/dasshbord_provider.dart';
import 'Wallet_sacreen.dart';


class DashboardScreen extends StatefulWidget {
  Future<bool> isMemberUser() async {
    final prefs = await SharedPreferences.getInstance();
    final memberType = prefs.getString('memberType') ?? '';
    return memberType == '0';
  }
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
      _DashboardItem(title: 'Network Tree', icon: Icons.account_tree, destination: const NetworkTree(), count: dashboard.networkCount),
      _DashboardItem(title: 'My KYC', icon: Icons.verified_user, destination: const MyKycScreen()),
      _DashboardItem(title: 'My Direct', icon: Icons.person_add, destination:  DirectScreen(), count: dashboard.directCount),
      _DashboardItem(title: 'My Network', icon: Icons.people, destination: const MyNetworkScreen(), count: dashboard.networkCount),
      // _DashboardItem(title: 'My Reward', icon: Icons.card_giftcard, destination: const MyRewardScreen(), count: dashboard.rewardCount),
      _DashboardItem(title: 'My Award', icon: Icons.emoji_events, destination: const MyAwardScreen(), ),
      _DashboardItem(title: 'My Detail Income', icon: Icons.attach_money, destination: const MyIncomeScreen()),
      _DashboardItem(title: 'New Member Registration', icon: Icons.app_registration, destination: const NewMemberRegistrationScreen()),
      _DashboardItem(title: 'Distributor ID Card', icon: Icons.badge, destination: const KycIdCardScreen()),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: HotstarDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        // title: // Important to apply gradient to image
        // Image.asset(
        //   'assets/images/logo.png', // Make sure this is added in pubspec.yaml
        //   height: 50,
        //   fit: BoxFit.contain,
        // ),
        title: ShaderMask(
          shaderCallback:
              (bounds) => LinearGradient(
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
                  icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WalletScreen()),
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
        centerTitle: true,
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


