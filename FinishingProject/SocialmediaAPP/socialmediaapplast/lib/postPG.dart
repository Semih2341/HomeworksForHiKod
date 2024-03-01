// ignore_for_file: unused_local_variable, file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, unnecessary_cast, empty_statements, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapplast/loginPG.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController _postTitleController = TextEditingController();
  TextEditingController _postContentController = TextEditingController();

  final firebasefirestore = FirebaseFirestore.instance;
  final firebaseauth = FirebaseAuth.instance;

  void _publishPost(String postTitle, String postContent) async {
    final denemeref = FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseauth.currentUser!.uid);
    var response = await denemeref.get();
    var veri = response.data()
        as Map<String, dynamic>?; // Cast to Map<String, dynamic>
    if (veri != null) {
      // Check if veri is not null

      ;
    }
    // Postu veritabanına kaydetme veya API'ye gönderme işlemi
    firebasefirestore.collection('Users').doc('Posts').collection('Posts').add({
      'user': veri!['username'],
      'userId': firebaseauth.currentUser!.uid,
      'title': postTitle,
      'content': postContent,
      'Likes': [],
    });

    // Ana sayfaya geri dön
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Oluştur'),
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
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextField(
                      controller: _postTitleController,
                      maxLines: null,
                      decoration:
                          const InputDecoration(labelText: 'Post Başlığı'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextField(
                      controller: _postContentController,
                      maxLines: null,
                      decoration:
                          const InputDecoration(labelText: 'Post İçeriği'),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
