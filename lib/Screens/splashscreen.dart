// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_week_16/Screens/authentication_page/login_page.dart';
import 'package:firebase_week_16/Screens/home_page.dart';
import 'package:firebase_week_16/widgets/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text(
                'Firebase',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              cheight20,
              cheight30,
               CircularProgressIndicator(
                color: Theme.of(context).colorScheme.inverseSurface,
                strokeWidth: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigation() async {
    await Future.delayed(const Duration(milliseconds: 900));
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Homepage(),
      ));
    }
  }
}
