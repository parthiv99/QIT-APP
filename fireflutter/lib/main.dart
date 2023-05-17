import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '/Screens/feed_screen.dart';
import '/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Models/posts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget getScreenId() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData && snapshot.data is User) {
            return FeedScreen(currentUserId: (snapshot.data as User).uid);
          } else {
            return WelcomeScreen();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Post>>(
          create: (_) => Post(
                  postId: '',
                  text: '',
                  timestamp: DateTime.now(),
                  uid: '',
                  username: '')
              .getAllPosts(),
          initialData: [],
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: getScreenId(),
      ),
    );
  }
}
