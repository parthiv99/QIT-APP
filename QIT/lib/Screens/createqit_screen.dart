import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing/Models/posts.dart';

class CreateQITScreen extends StatefulWidget {
  @override
  _CreateQITScreenState createState() => _CreateQITScreenState();
}

class _CreateQITScreenState extends State<CreateQITScreen> {
  final _qitController = TextEditingController();
  String _qitText = '';

  @override
  void initState() {
    super.initState();
    _qitController.addListener(_updateQitText);
  }

  void _updateQitText() {
    setState(() {
      _qitText = _qitController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create QIT'),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              User? currentUser = FirebaseAuth.instance.currentUser;

              if (currentUser != null && _qitText.isNotEmpty) {
                Post newPost = Post(
                  text: _qitText,
                  username: currentUser.displayName ?? '',
                  uid: currentUser.uid,
                  postId: '', // You can generate a unique postId here
                  timestamp: DateTime.now(),
                );

                await newPost.savePost();

                // Navigates back to the Home Screen
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                controller: _qitController,
                decoration: InputDecoration(
                  labelText: 'Compose QIT',
                  hintText: 'What do you want to ask?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 6,
                maxLength: 300,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _qitController.dispose();
    super.dispose();
  }
}
