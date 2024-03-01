// ignore_for_file: camel_case_types, file_names, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:socialmediaapplast/loginPG.dart';

class planetSelectionPG extends StatefulWidget {
  const planetSelectionPG({super.key});

  @override
  State<planetSelectionPG> createState() => _planetSelectionPGState();
}

class _planetSelectionPGState extends State<planetSelectionPG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.png'), fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 500.0, left: 50),
            child: SizedBox(
              width: 120,
              height: 120,
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    print('1.Gezegen');
                    Navigator.pushReplacementNamed(context, '/planet1');
                    planet = 0;
                  },
                  child: Text('')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 380, left: 160),
            child: SizedBox(
              width: 120,
              height: 120,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/planet2');
                  planet = 1;
                  print('2.Gezegen');
                },
                child: Text('Profile'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300, left: 275.0),
            child: SizedBox(
              width: 120,
              height: 120,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/planet3');
                  planet = 2;
                  print('3.Gezegen');
                },
                child: Text('Profile'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
