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
/// );P
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
    apiKey: 'AIzaSyA4EL6y-lbKhadZNDhYemI7Z9sdvM_tcy4',
    appId: '1:513585942851:web:4b5697f73cc5c175625ff6',
    messagingSenderId: '513585942851',
    projectId: 'socialmediaspace-9b48b',
    authDomain: 'socialmediaspace-9b48b.firebaseapp.com',
    storageBucket: 'socialmediaspace-9b48b.appspot.com',
    measurementId: 'G-SWZN8LGXY7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBH2h9-8YzOMs3oxGbsGF2mnYtHjUSiogs',
    appId: '1:513585942851:android:0d4ab4deab1f6640625ff6',
    messagingSenderId: '513585942851',
    projectId: 'socialmediaspace-9b48b',
    storageBucket: 'socialmediaspace-9b48b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-oHyGDfHZV6npiKIWo923eJOepcBd2yo',
    appId: '1:513585942851:ios:360623022aa90d7e625ff6',
    messagingSenderId: '513585942851',
    projectId: 'socialmediaspace-9b48b',
    storageBucket: 'socialmediaspace-9b48b.appspot.com',
    iosBundleId: 'com.example.spacesocial',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-oHyGDfHZV6npiKIWo923eJOepcBd2yo',
    appId: '1:513585942851:ios:a9605ff3491a7f4d625ff6',
    messagingSenderId: '513585942851',
    projectId: 'socialmediaspace-9b48b',
    storageBucket: 'socialmediaspace-9b48b.appspot.com',
    iosBundleId: 'com.example.spacesocial.RunnerTests',
  );
}