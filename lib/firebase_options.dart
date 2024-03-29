// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDB0GuYCSUlCT3gQAPd_B_QvbPj7x4sNdw',
    appId: '1:172426291116:web:e219e3081244e921177c09',
    messagingSenderId: '172426291116',
    projectId: 'week16-bc898',
    authDomain: 'week16-bc898.firebaseapp.com',
    storageBucket: 'week16-bc898.appspot.com',
    measurementId: 'G-CKLE4NZ8SX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9SijyBCcuiepnDNRvRtNh3UXd2wWcj2g',
    appId: '1:172426291116:android:582089bee469b606177c09',
    messagingSenderId: '172426291116',
    projectId: 'week16-bc898',
    storageBucket: 'week16-bc898.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUophwhhURj9Owx5aS-dY2bxgK4afGW30',
    appId: '1:172426291116:ios:ffe258a3a32992a1177c09',
    messagingSenderId: '172426291116',
    projectId: 'week16-bc898',
    storageBucket: 'week16-bc898.appspot.com',
    iosClientId: '172426291116-6q09i2vb6u5btg4q3r73be2m9jcc8hpr.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseWeek16',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCUophwhhURj9Owx5aS-dY2bxgK4afGW30',
    appId: '1:172426291116:ios:ffe258a3a32992a1177c09',
    messagingSenderId: '172426291116',
    projectId: 'week16-bc898',
    storageBucket: 'week16-bc898.appspot.com',
    iosClientId: '172426291116-6q09i2vb6u5btg4q3r73be2m9jcc8hpr.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseWeek16',
  );
}
