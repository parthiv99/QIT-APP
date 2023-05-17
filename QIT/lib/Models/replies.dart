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

class RepliesDialog extends StatefulWidget {
  final Post post;

  RepliesDialog({required this.post});

  @override
  _RepliesDialogState createState() => _RepliesDialogState();
}

class _RepliesDialogState extends State<RepliesDialog> {
  TextEditingController _replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User _userService = User();

    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.deepPurple, // Set purple background color
      content: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Container(
              color: Colors.deepPurple,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Replies',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  Text(widget.post.text),
                  SizedBox(height: 10),
                  StreamProvider<List<Reply>>.value(
                    value: widget.post.getReplies(widget.post.postId),
                    initialData: [],
                    child: Consumer<List<Reply>>(
                      builder: (context, replies, _) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: replies.length,
                          itemBuilder: (_, index) {
                            final reply = replies[index];
                            return StreamBuilder(
                              stream: _userService.getUserInfo(reply.uid),
                              builder: (BuildContext context,
                                  AsyncSnapshot<UserModel> snapshot) {
                                if (!snapshot.hasData) {
                                  return SizedBox.shrink();
                                }
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reply.text,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Replied by: ${snapshot.data!.name}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        reply.timestamp.toString(),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _replyController,
                    decoration: InputDecoration(
                      labelText: 'Add a reply',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      final auth.User? currentUser =
                          auth.FirebaseAuth.instance.currentUser;
                      if (currentUser != null &&
                          _replyController.text.isNotEmpty) {
                        Map<String, dynamic> replyData = {
                          'text': _replyController.text,
                          'username': currentUser.displayName ?? '',
                          'uid': currentUser.uid,
                          'timestamp': DateTime.now(),
                        };
                        await widget.post
                            .saveReply(widget.post.postId, replyData);
                        _replyController.clear();
                      }
                    },
                    child: Text('Submit'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ),
          ])),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
