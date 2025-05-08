import 'package:flutter/material.dart';
import 'package:hotstar/provider/auth_provider.dart';
import 'package:hotstar/provider/kyc_provider.dart';
import 'package:hotstar/provider/member_provider.dart';
import 'package:hotstar/provider/user_provider.dart';
import 'package:hotstar/provider/wallet_provider.dart';
import 'package:provider/provider.dart';
import 'bottamnavbar/bottamNav_Bar.dart';
import 'models/user_model.dart';
import 'models/wallet_model.dart';
import 'screens/auth_screen.dart';

void main() {
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
        ChangeNotifierProvider(create: (context) => MemberProvider()),
        ChangeNotifierProvider(create: (_) => KycProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
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
