import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:tiki/models/user.dart';
import 'package:tiki/respositories/baseloadusersrepo.dart';

class Usersdata extends BaseUsersRepo {
  final FirebaseFirestore _firestore;

  Usersdata({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<User>> getUsers() {
    var user = auth.FirebaseAuth.instance.currentUser;
    return _firestore
        .collection('users')
        .where('email', isNotEqualTo: user!.email)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return User.fromSnapshot(doc);
      }).toList();
    });
  }
}
