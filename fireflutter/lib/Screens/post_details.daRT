import 'package:flutter/material.dart';
import '/Models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/Models/post.dart';
import '/Services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:testing/Models/list.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:testing/Models/post.dart';
import 'package:testing/Models/posts.dart';
import 'package:testing/Models/user.dart';
import 'package:testing/Models/user_model.dart';
import 'package:testing/Screens/home_screen.dart';
import 'package:testing/Models/replies.dart';
import 'package:testing/Models/reply.dart';
import 'package:flutter/material.dart';
import 'package:testing/Models/post.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:testing/Models/list.dart';
import 'package:testing/Services/database_services.dart';
import 'package:testing/Models/replies.dart';



class PostDetailsScreen extends StatelessWidget {
  final Post post;

  const PostDetailsScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.text,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),

            SizedBox(height: 8),
            RepliesDialog(post: post), 
          ],
        ),
      ),
    );
  }
}