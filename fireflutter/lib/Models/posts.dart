import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:testing/Models/post.dart';
import 'package:testing/Models/reply.dart';
import 'package:testing/Models/user.dart';
import 'package:testing/Models/user_model.dart';

class Post {
  String text;
  String username;
  String uid;
  String postId;
  DateTime timestamp;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Post({
    required this.text,
    required this.username,
    required this.uid,
    required this.postId,
    required this.timestamp,
  });

  Future<void> savePost() async {
    await _firestore.collection('post').add({
      'text': text,
      'username': username,
      'uid': uid,
      'timestamp': timestamp,
    });
  }

  List<Post> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Post(
        text: data['text'] ?? '',
        username: data['username'] ?? '',
        uid: data['uid'] ?? '',
        postId: doc.id,
        timestamp: (data['timestamp'] as Timestamp).toDate(),
      );
    }).toList();
  }

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      text: doc['text'],
      username: doc['username'],
      uid: doc['uid'],
      postId: doc.id,
      timestamp: doc['timestamp'].toDate(),
    );
  }
  Stream<List<Post>> getAllPosts() {
    return _firestore
        .collection('post')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(_postListFromSnapshot);
  }

  static Future<List<Post>> search(String query) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('post')
        .where('text', isGreaterThanOrEqualTo: query)
        .get();

    return querySnapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
  }

  List<Reply> _replyListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Reply(
        text: data['text'] ?? '',
        username: data['username'] ?? '',
        uid: data['uid'] ?? '',
        timestamp: (data['timestamp'] as Timestamp).toDate(),
        replyId: '',
      );
    }).toList();
  }

  Stream<List<Reply>> getReplies(String postId) {
    return _firestore
        .collection('post') // Make sure to use the correct collection name
        .doc(postId)
        .collection('replies')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Reply.fromDocumentSnapshot(doc))
            .toList());
  }

  Future<void> saveReply(String postId, Map<String, dynamic> replyData) async {
    await _firestore
        .collection('post')
        .doc(postId)
        .collection('replies')
        .add(replyData);
  }
}
