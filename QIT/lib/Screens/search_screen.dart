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
import 'package:testing/Screens/post_details.daRT';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<QuerySnapshot>? _posts;
  TextEditingController _searchController = TextEditingController();
  DatabaseServices _databaseServices = DatabaseServices();

  clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _posts = null;
    });
  }

  buildPostTile(Post post) {
    return ListTile(
      title: Text(post.text),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailsScreen(post: post),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.deepPurple, // Updated background color
        title: TextField(
          controller: _searchController,
          style: TextStyle(color: Colors.white), // Updated text color
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15),
            hintText: 'Search posts...',
            hintStyle: TextStyle(color: Colors.white70), // Updated hint color
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.white),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                clearSearch();
              },
            ),
            filled: true,
            fillColor: Colors.deepPurple.shade300, // Updated fill color
          ),
          onChanged: (input) {
            if (input.isNotEmpty) {
              setState(() {
                _posts = _databaseServices.searchPosts(input);
              });
            }
          },
        ),
      ),
      body: _posts == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search,
                      size: 180,
                      color: Colors.deepPurple), // Updated icon color
                  Text(
                    'Search posts...',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.deepPurple), // Updated text color
                  ),
                ],
              ),
            )
          : FutureBuilder(
              future: _posts,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data.docs.length == 0) {
                  return Center(
                    child: Text('No posts found!'),
                  );
                }
                return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      Post post = Post.fromDocument(snapshot.data.docs[index]);
                      return buildPostTile(post);
                    });
              },
            ),
    );
  }
}
