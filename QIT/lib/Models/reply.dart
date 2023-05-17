import 'package:cloud_firestore/cloud_firestore.dart';

class Reply {
  String replyId;
  String text;
  String username;
  String uid;
  DateTime timestamp;

  Reply({
    required this.replyId,
    required this.text,
    required this.username,
    required this.uid,
    required this.timestamp,
  });

  factory Reply.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Reply(
      replyId: doc.id,
      text: doc['text'],
      username: doc['username'],
      uid: doc['uid'],
      timestamp: doc['timestamp'].toDate(),
    );
  }
}
