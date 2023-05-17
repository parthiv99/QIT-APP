import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing/Models/user_model.dart';
import 'package:testing/Services/utils.dart';
import 'package:testing/Models/user_model.dart';

class User {
  UtilsService _utilsService = UtilsService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel? _userFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return snapshot != null
        ? UserModel(
            id: snapshot.id,
            name: data['name'],
            email: data['email'],
            text: data['text'])
        : null;
  }

  Stream<UserModel> getUserInfo(uid) {
    print('Document path: $uid');
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(_userFromFirebaseSnapshot as UserModel Function(
            DocumentSnapshot<Map<String, dynamic>> event));
  }
}
