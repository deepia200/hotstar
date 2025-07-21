// lib/Drawer/refer&ern.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashbord/Detail_screen.dart';
import 'package:hotstar/service/api_methods.dart';

import '../screens/Wallet_sacreen.dart';
import '../service/api_methods.dart'; // Make sure this path is correct

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({super.key});

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {
  String? referralCode;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadReferralCode();
  }

  Future<void> loadReferralCode() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('id') ?? ''; // e.g. RLID000010

    if (userId.isEmpty) {
      setState(() {
        referralCode = 'Unavailable';
        isLoading = false;
      });
      return;
    }

    final code = await ApiMethods().fetchReferralCode(userId);

    setState(() {
      referralCode = code ?? 'Unavailable';
      isLoading = false;
    });
  }

  void _copyToClipboard(BuildContext context) {
    if (referralCode == null) return;
    Clipboard.setData(ClipboardData(text: referralCode!));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Referral code copied!')),
    );
  }

  void _shareReferral(BuildContext context) {
    if (referralCode == null) return;
    final String message =
        "Join me on Reel Life OTT! Use my referral code *$referralCode* and get exciting rewards.\n\nDownload the app now!";
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Refer & Earn',
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyIncomeScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () => _shareReferral(context),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.card_giftcard, size: 80, color: Colors.orangeAccent),
            const SizedBox(height: 20),
            Text(
              'Invite your friends & earn rewards!',
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Share your referral code and get bonus rewards when your friends join and complete their KYC!',
              style: GoogleFonts.roboto(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      referralCode ?? '',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _shareReferral(context),
                    // onPressed: () => _copyToClipboard(context),
                    icon: const Icon(Icons.copy, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
