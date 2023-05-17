import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:testing/Models/posts.dart';
import 'package:testing/Models/user.dart';
import 'package:testing/Models/user_model.dart';
import 'package:testing/Models/replies.dart';
import 'package:testing/Models/reply.dart';

class ListPosts extends StatefulWidget {
  const ListPosts({Key? key}) : super(key: key);

  @override
  State<ListPosts> createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  User _userService = User();

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>>(context) ?? [];
    print('Number of posts: ${posts.length}');
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return StreamBuilder(
          stream: _userService.getUserInfo(post.uid),
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return Card(
              color: Color.fromARGB(255, 54, 28, 102),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 10),
                      child: DefaultTextStyle(
                        style: TextStyle(color: Colors.blue),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.text,
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 20),
                            Text(
                              post.timestamp.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Posted by: ${snapshot.data!.name}',
                                  style: TextStyle(fontSize: 12),
                                ),
                                IconButton(
                                  icon: Icon(Icons.chat_bubble_outline),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RepliesDialog(post: post),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 10),
                    StreamProvider<List<Reply>>.value(
                      value: post.getReplies(post.postId),
                      initialData: [],
                      child: Consumer<List<Reply>>(
                        builder: (context, replies, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: replies.length,
                            itemBuilder: (_, index) {
                              final reply = replies[index];
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
