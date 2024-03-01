// ignore_for_file: file_names, camel_case_types, prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:socialmediaapplast/loginPG.dart';

class secondPlanetPG extends StatefulWidget {
  secondPlanetPG({super.key});

  @override
  State<secondPlanetPG> createState() => _secondPlanetPGState();
}

class _secondPlanetPGState extends State<secondPlanetPG>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isPlaying = true;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        //animasyon bitince ne olacak
        print('animasyon bitti');
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !isPlaying
            ? LogInPG()
            : Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 430,
                      height: 950,
                      child: Container(
                        child: Lottie.asset(
                          'assets/planet2.json',
                          animate: true,
                          repeat: false,
                          fit: BoxFit.fill,
                          controller: _controller,
                          onLoaded: (composition) {
                            _controller.duration = composition.duration;
                            _controller.forward();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
