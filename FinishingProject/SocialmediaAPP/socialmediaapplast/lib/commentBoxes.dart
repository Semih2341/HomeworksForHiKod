// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:socialmediaapplast/profile.dart';

class CommentBoxes extends StatelessWidget {
  final String postexp;
  final String username;
  final bool deletable;
  final dynamic post;
  const CommentBoxes(
      {required this.username,
      required this.postexp,
      required this.deletable,
      required this.post,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                padding: const EdgeInsets.only(left: 22.0),
                child: Text(
                  username,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      postexp,
                      style: const TextStyle(fontSize: 25),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  if (deletable)
                    IconButton(
                        onPressed: () {
                          konum.clear();
                          post.delete();
                        }, //post.delete(),
                        icon: const Icon(Icons.delete))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
