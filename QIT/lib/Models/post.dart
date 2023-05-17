import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostModel {
  final String text;
  final String uid;
  final String username;
  final String postId;
  final Timestamp timestamp;
  DocumentReference ref;

  PostModel({
    required this.text,
    required this.username,
    required this.uid,
    required this.postId,
    required this.timestamp,
    required this.ref,
  });
}
