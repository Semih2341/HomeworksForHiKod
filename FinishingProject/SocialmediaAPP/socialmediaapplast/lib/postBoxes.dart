// ignore_for_file: must_be_immutable, file_names, annotate_overrides, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapplast/like_button.dart';
import 'package:socialmediaapplast/profile.dart';

String commentUsername = '';
String commentPostTitle = '';
String commentPostContent = '';
String commentPostID = '';

class PostLoad extends StatefulWidget {
  final String postcontent;
  final String posttitle;
  final String username;
  final bool deletable;
  final bool isComment;
  final dynamic post;
  final String postID;
  List likes = [];

  PostLoad(
      {required this.isComment,
      required this.postID,
      required this.username,
      required this.posttitle,
      required this.postcontent,
      required this.deletable,
      required this.post,
      required this.likes,
      super.key});

  @override
  State<PostLoad> createState() => _PostLoadState();
}

class _PostLoadState extends State<PostLoad> {
  final firebasefirestore = FirebaseFirestore.instance;
  final firebaseauth = FirebaseAuth.instance;
  bool _isLiked = false;
  void initState() {
    super.initState();

    _isLiked = widget.likes.contains(firebaseauth.currentUser!.email);
  }

  void likePost(String postID) async {
    setState(
      () {
        _isLiked = !_isLiked;
      },
    );
    DocumentReference referans = firebasefirestore
        .collection('Users')
        .doc('Posts')
        .collection('Posts')
        .doc(postID);
    if (_isLiked) {
      referans.update({
        'Likes': FieldValue.arrayUnion([firebaseauth.currentUser!.email])
      });
    } else {
      referans.update({
        'Likes': FieldValue.arrayRemove([firebaseauth.currentUser!.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Expanded(
                  child: Text(
                    widget.username,
                    style: const TextStyle(fontSize: 15),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                widget.posttitle,
                style: const TextStyle(fontSize: 25),
                overflow: TextOverflow.visible,
              ),
              const Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.postcontent,
                      style: const TextStyle(fontSize: 20),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!widget.isComment)
                    LikeButton(
                        isLiked: _isLiked,
                        onTap: () {
                          setState(() {
                            likePost(widget.postID);
                          });
                        }),
                  const SizedBox(
                    width: 10,
                  ),
                  if (!widget.isComment) Text(widget.likes.length.toString()),
                  const SizedBox(
                    width: 10,
                  ),
                  if (!widget.isComment)
                    IconButton(
                        onPressed: () {
                          commentPostContent = widget.postcontent;
                          commentPostTitle = widget.posttitle;
                          commentUsername = widget.username;
                          commentPostID = widget.postID;
                          Navigator.pushNamed(
                            context,
                            '/commentPG',
                          );
                        },
                        icon: const Icon(Icons.comment)),
                  if (widget.deletable)
                    IconButton(
                        onPressed: () {
                          konum.clear();
                          widget.post.delete();
                        }, //post.delete(),
                        icon: const Icon(Icons.delete))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
