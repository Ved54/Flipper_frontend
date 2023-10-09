import 'package:firebase_core/firebase_core.dart';
import 'package:mazha_app/providers/internet_provider.dart';
import 'package:mazha_app/providers/profile_provider.dart';
import 'package:mazha_app/providers/sign_in_provider.dart';
import 'package:mazha_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'Chats/provider/firebase_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => ProfileProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => FirebaseProvider()),
        ),
      ],
      child: MaterialApp(
        debugShowMaterialGrid: false,
        theme: ThemeData(
          primarySwatch: MaterialColor(0xFF4EDB86, {
            50: Color(0xFF4EDB86),
            100: Color(0xFF4EDB86),
            200: Color(0xFF4EDB86),
            300: Color(0xFF4EDB86),
            400: Color(0xFF4EDB86),
            500: Color(0xFF4EDB86),
            600: Color(0xFF4EDB86),
            700: Color(0xFF4EDB86),
            800: Color(0xFF4EDB86),
            900: Color(0xFF4EDB86)
          }),
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
