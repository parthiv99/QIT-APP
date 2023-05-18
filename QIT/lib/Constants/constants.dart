import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

final _fireStore = FirebaseFirestore.instance;

final usersRef = _fireStore.collection('users');

final storageRef = FirebaseStorage.instance.ref();
