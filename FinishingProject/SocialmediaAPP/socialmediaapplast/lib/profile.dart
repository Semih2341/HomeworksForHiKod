// ignore_for_file: unused_local_variable, camel_case_types, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapplast/loginPG.dart';
import 'package:socialmediaapplast/postBoxes.dart';

List konum = [];

class profilePG extends StatefulWidget {
  const profilePG({super.key});

  @override
  State<profilePG> createState() => _profilePGState();
}

class _profilePGState extends State<profilePG> {
  final firebasefirestore = FirebaseFirestore.instance;
  final firebaseauth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference referans =
        firebasefirestore.collection('Users').doc('Posts').collection('Posts');
    final userPosts =
        referans.where('userId', isEqualTo: firebaseauth.currentUser!.uid);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Yenileme düğmesine basıldığında burada bir işlem yapılabilir
              // Örneğin, verileri yenileme veya başka bir işlem gerçekleştirme
              setState(() {
                int i = 0;
                i++;
                konum.clear();
              });
            },
          ),
        ],
        title: const Text('Profile'),
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
          StreamBuilder(
            stream: userPosts.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Bir hata oluştu');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Yükleniyor...');
              }

              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return PostLoad(
                        isComment: false,
                        postID: snapshot.data!.docs[index].id,
                        username: snapshot.data!.docs[index]['user'],
                        posttitle: snapshot.data!.docs[index]['title'],
                        postcontent: snapshot.data!.docs[index]['content'],
                        deletable: true,
                        likes: List<String>.from(
                            snapshot.data!.docs[index]['Likes'] ?? []),
                        post: snapshot.data!.docs[index].reference);
                  },
                ),
                //Text(snapshot.data!.docs[0]),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/postPG');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1.6,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
