import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:testing/Models/list.dart';
import 'package:testing/Models/posts.dart';
import 'package:provider/provider.dart';
import 'package:testing/Models/post.dart';

import '../Screens/createqit_screen.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Post _postService = Post(
      text: '',
      username: '',
      uid: '',
      postId: '',
      timestamp: DateTime.now(),
    );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 82, 11, 140),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Image.asset('assets/qitLogo.png'),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateQITScreen()));
          }),
      body: StreamProvider<List<Post>>.value(
        value: _postService.getAllPosts(),
        initialData: [],
        child: ListPosts(),
      ),
    );
  }
}
