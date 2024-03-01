import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapplast/loginPG.dart';

class SignupPG extends StatefulWidget {
  const SignupPG({Key? key}) : super(key: key);

  @override
  _SignupPGState createState() => _SignupPGState();
}

class _SignupPGState extends State<SignupPG> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final firebaseauth = FirebaseAuth.instance;
  final firebasefirestore = FirebaseFirestore.instance;
  String userPlanet = '';
  void initState() {
    super.initState();
    print('Gezegen İsmi ' + planet.toString());
    if (planet == 0) {
      userPlanet = ' -Yıldıztutuşlu';
      print(userPlanet);
    } else if (planet == 1) {
      userPlanet = ' -Gökyakutlu';
      print(userPlanet);
    } else if (planet == 2) {
      userPlanet = ' -Ufkayelli';
      print(userPlanet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
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
            padding: const EdgeInsets.fromLTRB(16.0, 160.0, 16.0, 16.0),
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
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Lütfen Bilgileri Girin';
                          }
                        },
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Adınız'),
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
                        controller: _usernameController,
                        decoration:
                            const InputDecoration(labelText: 'kullancı adı'),
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
                        onSaved: (value) {
                          _emailController.text = value!;
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
                        onSaved: (value) {
                          _passwordController.text = value!;
                        },
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Şifre'),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        // Kayıt işlemini gerçekleştir
                        if (formkey.currentState!.validate()) {
                          formkey.currentState!.save();
                          print(_nameController.text);
                          print(_emailController.text);
                          print(_passwordController.text);
                          try {
                            var userResult = await firebaseauth
                                .createUserWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                            try {
                              final result = await firebasefirestore
                                  .collection('Users')
                                  .doc(firebaseauth.currentUser!.uid)
                                  .set({
                                'name': _nameController.text,
                                'username':
                                    _usernameController.text + userPlanet,
                              });
                            } catch (e) {
                              print(e);
                            }
                            print(userResult.user!.uid);
                            formkey.currentState!.reset();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Kayıt Başarılı Login Ekranına Yönlendiriliyorsunuz'),
                              ),
                            );
                            Navigator.pop(context);
                          } on FirebaseAuthException catch (e) {
                            print(e.message);
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            }
                          }
                        }
                      },
                      child: const Text('Kayıt Ol'),
                    ),
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
