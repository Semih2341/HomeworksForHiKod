import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:socialmediaapplast/loginPG.dart';

class secondPlanetReversedPG extends StatefulWidget {
  secondPlanetReversedPG({super.key});

  @override
  State<secondPlanetReversedPG> createState() => _secondPlanetReversedPGState();
}

class _secondPlanetReversedPGState extends State<secondPlanetReversedPG>
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
          Navigator.pushNamedAndRemoveUntil(
              context, '/planetSelection', (route) => false);
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
                          'assets/planet2reversed.json',
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
