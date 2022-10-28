import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_week_16/Screens/authentication_page/login_page.dart';
import 'package:firebase_week_16/firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
       
      ),
      home:  LoginPage(),
    );
  }
}
