// ignore_for_file: unused_local_variable, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapplast/commentBoxes.dart';
import 'package:socialmediaapplast/loginPG.dart';
import 'package:socialmediaapplast/mainPage.dart';
import 'package:socialmediaapplast/postBoxes.dart';

class CommentPG extends StatefulWidget {
  const CommentPG({
    super.key,
  });

  @override
  State<CommentPG> createState() => _CommentPGState();
}

class _CommentPGState extends State<CommentPG> {
  final firebasefirestore = FirebaseFirestore.instance;
  final firebaseauth = FirebaseAuth.instance;
  void addtoarray() {
    var deneyim = firebasefirestore.collection('Users').doc('Users');
  }

  var denemetext = "";

  @override
  Widget build(BuildContext context) {
    getUsername(firebaseauth.currentUser!.uid);
    CollectionReference referans = firebasefirestore
        .collection('Users')
        .doc('Posts')
        .collection('Posts')
        .doc('Comments')
        .collection('Comments');
    final comments = referans.where('ownerPost', isEqualTo: commentPostID);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Yenileme düğmesine basıldığında burada bir işlem yapılabilir
              // Örneğin, verileri yenileme veya başka bir işlem gerçekleştirme
              getUsername(firebaseauth.currentUser!.uid);
              setState(() {
                denemetext = 'Yenilendi';
                int i = 0;
                i++;
              });
            },
          ),
        ],
        title: Text('Yorumlar'),
      ),
      body: /*ElevatedButton(
        onPressed: () async {
          var response = await denemeref.get();
          var veri = response.data()
              as Map<String, dynamic>?; // Cast to Map<String, dynamic>
          if (veri != null) {
            // Check if veri is not null
            var documentSnapshot =
                await firebasefirestore.collection('Users').doc('deneme').get();
            var deneme2 = documentSnapshot.data()!['icerik'];
            print(deneme2);
          }
        },
        child: Text(denemetext),
      ),*/

          Stack(
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
          ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              PostLoad(
                isComment: true,
                likes: const [],
                username: commentUsername,
                postcontent: commentPostContent,
                deletable: false,
                post: '',
                postID: commentPostID,
                posttitle: commentPostTitle,
              ),
            ],
          ),
          StreamBuilder(
            stream: comments.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Bir hata oluştu');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Yükleniyor...');
              }

              return Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Center(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return CommentBoxes(
                            username: snapshot.data!.docs[index]['user'],
                            postexp: snapshot.data!.docs[index]['content'],
                            deletable: false,
                            post: snapshot.data!.docs[index].reference);
                      }),
                  //Text(snapshot.data!.docs[0]),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(width: 1.6, color: Colors.white),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/commentCreator');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

