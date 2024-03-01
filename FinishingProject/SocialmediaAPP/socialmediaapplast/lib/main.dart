// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socialmediaapplast/commentCreator.dart';
import 'package:socialmediaapplast/firstPlanetSelected.dart';
import 'package:socialmediaapplast/firstplanetreversed.dart';
import 'package:socialmediaapplast/loginPG.dart';
import 'package:socialmediaapplast/mainPage.dart';
import 'package:socialmediaapplast/planetSelection.dart';
import 'package:socialmediaapplast/postPG.dart';
import 'package:socialmediaapplast/profile.dart';
import 'package:socialmediaapplast/secondPlanetSelected.dart';
import 'package:socialmediaapplast/secondplanetreversed.dart';
import 'package:socialmediaapplast/thirdPlanetSelected.dart';
import 'package:socialmediaapplast/thirdplanetreversed.dart';
import 'commentPG.dart';
import 'firebase_options.dart';
import 'signupPG.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/signUpPG': (context) => const SignupPG(),
        '/loginPG': (context) => const LogInPG(),
        '/mainPG': (context) => const mainPG(),
        '/postPG': (context) => PostPage(),
        '/profilePG': (context) => const profilePG(),
        '/commentPG': (context) => CommentPG(),
        '/commentCreator': (context) => CommentCreator(),
        '/planet1': (context) => firstPlanetPG(),
        '/planet2': (context) => secondPlanetPG(),
        '/planet3': (context) => thirdPlanetPG(),
        '/planet1reversed': (context) => firstPlanetReversedPG(),
        '/planet2reversed': (context) => secondPlanetReversedPG(),
        '/planet3reversed': (context) => thirdPlanetReversedPG(),
        '/planetSelection': (context) => planetSelectionPG(),
      },
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[900],
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Colors.white, fontSize: 20),
          fillColor: Colors.black,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[800]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[800]!),
          ),
        ),
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
            background: Colors.black,
            primary: Colors.grey[900]!,
            secondary: Colors.grey[800]!),

        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.

        useMaterial3: true,
      ),
      home: planetSelectionPG(),
    );
  }
}
