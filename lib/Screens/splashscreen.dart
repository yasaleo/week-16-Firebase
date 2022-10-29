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
            children: const [
              Text(
                'Firebase',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 5,
                ),
              ),
              cheight20,
              cheight30,
              CircularProgressIndicator(
                color: Colors.black,
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
        builder: (context) => LoginPage(),
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Homepage(),
      ));
    }
  }
}
