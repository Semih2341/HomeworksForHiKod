// ignore_for_file: file_names, camel_case_types, sort_child_properties_last, avoid_unnecessary_containers, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapplast/postBoxes.dart';
import 'package:socialmediaapplast/profile.dart';
import 'package:socialmediaapplast/loginPG.dart';

class mainPG extends StatefulWidget {
  const mainPG({super.key});
  static String username = "";
  @override
  State<mainPG> createState() => _mainPGState();
}

class _mainPGState extends State<mainPG> {
  final firebasefirestore = FirebaseFirestore.instance;
  final firebaseauth = FirebaseAuth.instance;
  void addtoarray() {}

  var denemetext = "";
  @override
  void initState() {
    super.initState();
    getUsername(firebaseauth.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference referans =
        firebasefirestore.collection('Users').doc('Posts').collection('Posts');

    return Scaffold(
      drawer: MyDrawer(username: mainPG.username),
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
              });
            },
          ),
        ],
        title: Text('Ana Sayfa'),
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
          StreamBuilder(
            stream: referans.snapshots(),
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
                          likes: List<String>.from(
                              snapshot.data!.docs[index]['Likes'] ?? []),
                          deletable: false,
                          post: snapshot.data!.docs[index].reference);
                    }),
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
          side: BorderSide(
            width: 1.6,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

class MyDrawer extends StatelessWidget {
  final String username;
  const MyDrawer({required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: CircleAvatar(
                          radius: 47,
                          backgroundImage: NetworkImage(
                              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(username,
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profil'),
                  onTap: () {
                    konum.clear();
                    Navigator.popAndPushNamed(context, '/profilePG');
                  } // Bu, çekmecenin kapatılmasını sağlar
                  ),
              ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('AnaMenü'),
                  onTap: () {
                    konum.clear();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/mainPG', (route) => false);
                  } // Bu, çekmecenin kapatılmasını sağlar
                  ),
            ],
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Çıkış Yap'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/loginPG', (route) => false);
                },
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

void getUsername(String uid) async {
  final denemeref = FirebaseFirestore.instance.collection('Users').doc(uid);
  var response = await denemeref.get();
  var veri =
      response.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
  if (veri != null) {
    // Check if veri is not null

    mainPG.username = veri['username'];
  }
}
