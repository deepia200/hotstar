// import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotstar/provider/auth_provider.dart';
import 'package:hotstar/provider/dasshbord_provider.dart';
import 'package:hotstar/provider/episode_provider.dart';
import 'package:hotstar/provider/kyc_provider.dart';
import 'package:hotstar/provider/member_provider.dart';
import 'package:hotstar/provider/user_provider.dart';
import 'package:hotstar/provider/wallet_provider.dart';
import 'package:provider/provider.dart';
import 'bottamnavbar/bottamNav_Bar.dart';
import 'models/user_model.dart';
import 'screens/auth_screen.dart';


void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // Force system bars (status + nav) to be black with light icons
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    systemNavigationBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Allow app to go full screen edge-to-edge
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MemberProvider()),
        ChangeNotifierProvider(create: (_) => KycProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => EpisodeProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Provider Auth Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.black,
          hintColor: Colors.blueAccent,
        ),
        home: const BottomNavBarScreen(),
      ),
    );
  }
}