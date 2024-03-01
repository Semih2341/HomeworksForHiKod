import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapplast/firstPlanetSelected.dart';
import 'package:socialmediaapplast/main.dart';
import 'package:socialmediaapplast/planetSelection.dart';

int planet = 0;

class LogInPG extends StatefulWidget {
  const LogInPG({Key? key}) : super(key: key);

  @override
  _LogInPGState createState() => _LogInPGState();
}

class _LogInPGState extends State<LogInPG> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final firebaseauth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
        actions: [
          IconButton(
            onPressed: () {
              if (planet == 0) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/planet1reversed', (route) => false);
              } else if (planet == 1) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/planet2reversed', (route) => false);
              } else if (planet == 2) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/planet3reversed', (route) => false);
              }
            },
            icon: const Icon(Icons.rocket_launch),
          ),
        ],
      ),
      body: Stack(
        children: [
          if (planet == 0)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/planet1.png'), fit: BoxFit.fill),
              ),
            ),
          if (planet == 1)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/planet2.png'), fit: BoxFit.fill),
              ),
            ),
          if (planet == 2)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/planet3.png'), fit: BoxFit.fill),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 250.0, 16.0, 16.0),
            child: Form(
              key: formkey,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lütfen Bilgileri Girin';
                          }
                        },
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'E-posta'),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lütfen Bilgileri Girin';
                          }
                        },
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Şifre'),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          try {
                            var userResult =
                                await firebaseauth.signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController
                                        .text); // Kayıt işlemini gerçekleştir
                            print(userResult.user!.uid + 'giriş yapıldı');
                            formkey.currentState!.reset();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Giriş Yapıldı'),
                              ),
                            );
                            Navigator.popAndPushNamed(context, '/mainPG');
                          } on FirebaseAuthException catch (e) {
                            print(e.message);
                          }
                        }

                        // Kayıt işlemini gerçekleştir
                      },
                      child: const Text('Giriş Yap'),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signUpPG');
                        },
                        child: const Text('Kayıt Ol')),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
