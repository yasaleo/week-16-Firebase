import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_week_16/Screens/splashscreen.dart';
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
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 70),
           displaySmall: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          brightness: Brightness.dark,
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 70,
            ),
            displaySmall: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          )),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
