// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBXCNZE7ikK8jo9YxxumoKLNyAud9WNu_c',
    appId: '1:200255825364:web:f89625787ecdfbd60a6241',
    messagingSenderId: '200255825364',
    projectId: 'health-mate-7885e',
    authDomain: 'health-mate-7885e.firebaseapp.com',
    storageBucket: 'health-mate-7885e.firebasestorage.app',
    measurementId: 'G-C51WJKNY29',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA--1LYfiHKFhNtTMdMWqd95sDxuy2XhY8',
    appId: '1:200255825364:android:ec206d019a9816050a6241',
    messagingSenderId: '200255825364',
    projectId: 'health-mate-7885e',
    storageBucket: 'health-mate-7885e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCI-RXX0xcXSU65sdG0Ej73aPUj3PN_z7g',
    appId: '1:200255825364:ios:20dcef5d4fbe8b800a6241',
    messagingSenderId: '200255825364',
    projectId: 'health-mate-7885e',
    storageBucket: 'health-mate-7885e.firebasestorage.app',
    iosBundleId: 'com.example.healthMate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCI-RXX0xcXSU65sdG0Ej73aPUj3PN_z7g',
    appId: '1:200255825364:ios:20dcef5d4fbe8b800a6241',
    messagingSenderId: '200255825364',
    projectId: 'health-mate-7885e',
    storageBucket: 'health-mate-7885e.firebasestorage.app',
    iosBundleId: 'com.example.healthMate',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBXCNZE7ikK8jo9YxxumoKLNyAud9WNu_c',
    appId: '1:200255825364:web:20ada7ec39a5f5830a6241',
    messagingSenderId: '200255825364',
    projectId: 'health-mate-7885e',
    authDomain: 'health-mate-7885e.firebaseapp.com',
    storageBucket: 'health-mate-7885e.firebasestorage.app',
    measurementId: 'G-1S9Y4TZY41',
  );
}
