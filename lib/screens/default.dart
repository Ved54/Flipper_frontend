import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sign_in_provider.dart';
import '../utils/nav_bar.dart';
import 'login_screen.dart';

class Default extends StatefulWidget {
  const Default({super.key});

  @override
  State<Default> createState() => _DefaultState();
}

class _DefaultState extends State<Default> {

  @override
  Widget build(BuildContext context) {

    final sp = context.read<SignInProvider>();
    sp.checkSignInUser();

    return sp.isSignedIn ? NavBar() : LoginScreen();
  }
}
