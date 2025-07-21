// // import 'package:firebase_core/firebase_core.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hotstar/provider/auth_provider.dart';
// import 'package:hotstar/provider/dasshbord_provider.dart';
// import 'package:hotstar/provider/episode_provider.dart';
// import 'package:hotstar/provider/home_prover.dart';
// import 'package:hotstar/provider/kyc_provider.dart';
// import 'package:hotstar/provider/member_provider.dart';
// import 'package:hotstar/provider/user_provider.dart';
// import 'package:hotstar/provider/wallet_provider.dart';
// import 'package:hotstar/splash/splash_screen.dart';
// import 'package:provider/provider.dart';
// import 'bottamnavbar/bottamNav_Bar.dart';
// import 'models/user_model.dart';
// import 'screens/auth_screen.dart';
//
//
// void main() async{
//
//   WidgetsFlutterBinding.ensureInitialized();
//
//   final authProvider = AuthProvider();
//   await authProvider.loadSavedLogin();
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//
//   // Force system bars (status + nav) to be black with light icons
//   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     statusBarColor: Colors.black,
//     systemNavigationBarColor: Colors.black,
//     statusBarIconBrightness: Brightness.light,
//     systemNavigationBarIconBrightness: Brightness.light,
//   ));
//
//   // Allow app to go full screen edge-to-edge
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // ChangeNotifierProvider(create: (_) => UserModel(name: 'null', email: "null", birthdate: 'null')),
//         ChangeNotifierProvider(create: (_) => WalletProvider()),
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//         ChangeNotifierProvider(create: (_) => MemberProvider()),
//         ChangeNotifierProvider(create: (_) => KycProvider()),
//         ChangeNotifierProvider(create: (_) => UserProvider()),
//         ChangeNotifierProvider(create: (_) => EpisodeProvider()),
//         // ChangeNotifierProvider(create: (_) => HomeProvider()),
//         ChangeNotifierProvider(create: (_) => DashboardProvider()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Provider Auth Demo',
//         theme: ThemeData.dark().copyWith(
//           scaffoldBackgroundColor: Colors.black,
//           primaryColor: Colors.black,
//           hintColor: Colors.blueAccent,
//         ),
//         home:  BottomNavBarScreen(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotstar/screens/home_Screen.dart';
import 'package:provider/provider.dart';

import 'bottamnavbar/bottamNav_Bar.dart';
import 'screens/dashboard_screen.dart';
import 'provider/auth_provider.dart';
import 'provider/wallet_provider.dart';
import 'provider/kyc_provider.dart';
import 'provider/member_provider.dart';
import 'provider/user_provider.dart';
import 'provider/episode_provider.dart';
import 'provider/dasshbord_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = AuthProvider();
  await authProvider.loadSavedLogin(); // Load login state before app starts

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    systemNavigationBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(MyApp(authProvider: authProvider));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;
  const MyApp({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    // Determine which screen to start with
    Widget initialScreen;

    if (!authProvider.isAuthenticated) {
      initialScreen = HomeScreen();
    } else {
      if (authProvider.memberType == '0') {
        initialScreen = HomeScreen();
      } else {
        initialScreen = HomeScreen();
      }
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
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
        home: initialScreen,
      ),
    );
  }
}
