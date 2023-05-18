import 'package:cloud_firestore/cloud_firestore.dart';
import '/Constants/constants.dart';
import '/Models/user_model.dart';

class DatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference postsRef =
      FirebaseFirestore.instance.collection('posts');
  static Future<void> addPost(
      String userId, String username, String content) async {
    DocumentReference postRef = await postsRef.add({
      'userId': userId,
      'username': username,
      'content': content,
      'timestamp': Timestamp.now(),
    });

    DocumentSnapshot userSnapshot = await usersRef.doc(userId).get();
    int postCount = userSnapshot.get('postCount') ?? 0;
    usersRef.doc(userId).update({'postCount': postCount + 1});
  }

  static void updateUserData(UserModel user) {
    usersRef.doc(user.id).update({
      'name': user.name,
    });
  }

  static Future<QuerySnapshot> searchUsers(String name) async {
    Future<QuerySnapshot> users = usersRef
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThan: name + 'z')
        .get();

    return users;
  }

  Future<QuerySnapshot> searchPosts(String query) async {
    return await _firestore
        .collection('post')
        .where('text', isGreaterThanOrEqualTo: query)
        .get();
  }
}
