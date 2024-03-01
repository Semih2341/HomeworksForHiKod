// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapplast/loginPG.dart';
import 'package:socialmediaapplast/postBoxes.dart';

class CommentCreator extends StatefulWidget {
  const CommentCreator({super.key});

  @override
  _CommentCreatorState createState() => _CommentCreatorState();
}

class _CommentCreatorState extends State<CommentCreator> {
  final TextEditingController _postTitleController = TextEditingController();
  final TextEditingController _postContentController = TextEditingController();

  final firebasefirestore = FirebaseFirestore.instance;
  final firebaseauth = FirebaseAuth.instance;

  void _publishPost(String postTitle, String postContent) async {
    final denemeref = FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseauth.currentUser!.uid);
    var response = await denemeref.get();
    var veri = response.data(); // Cast to Map<String, dynamic>
    if (veri != null) {
      // Check if veri is not null
    }
    // Postu veritabanına kaydetme veya API'ye gönderme işlemi
    firebasefirestore
        .collection('Users')
        .doc('Posts')
        .collection('Posts')
        .doc('Comments')
        .collection('Comments')
        .add({
      'user': veri!['username'],
      'userId': firebaseauth.currentUser!.uid,
      'content': postContent,
      'ownerPost': commentPostID,
    });

    // Ana sayfaya geri dön
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yorum Oluştur'),
      ),
      body: Stack(
        children: [
          if (planet == 0)
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/planet1.png'), fit: BoxFit.fill),
              ),
            ),
          if (planet == 1)
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/planet2.png'), fit: BoxFit.fill),
              ),
            ),
          if (planet == 2)
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/planet3.png'), fit: BoxFit.fill),
              ),
            ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextField(
                      controller: _postContentController,
                      decoration:
                          const InputDecoration(labelText: 'Yorum İçeriği'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        int i = 0;
                        i++;
                      });
                      _publishPost(_postTitleController.text,
                          _postContentController.text);
                    },
                    child: const Text('Yayınla'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
