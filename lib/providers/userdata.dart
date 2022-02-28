import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String? _username;
  String? imageUrl;
  String? age;
  List? interests;
  var currentUser = FirebaseAuth.instance.currentUser;

  Future<void> _getUser() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc((FirebaseAuth.instance.currentUser!.email))
        .get()
        .then((value) {
      _username = value.data()!['username'];
      imageUrl = value.data()!['imageUrl'][0];
      age = value.data()!['age'];
      interests = value.data()!['interest'];
      notifyListeners();
    });
  }

  Future<DocumentSnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc((FirebaseAuth.instance.currentUser!.email))
        .get();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future<void> saveLikedUser(
      {required String likedUsername,
      required String likedUserage,
      required List imageurls,
      required List likedUserInterest,
      required String likedUseremail,
      required String likedUserAddress,
      required String currentUsername,
      required String job,
      required List currentUserImageurls,
      required String currentUserAge,
      required List currentUserInterest,
      required String currentUserAddress,
      required String currentoccupation,
      required String occupation}) {
    return FirebaseFirestore.instance.collection('likeduser').doc().set({
      'email': FirebaseAuth.instance.currentUser!.email,
      'username': currentUsername,
      'imageUrl': currentUserImageurls,
      'age': currentUserAge,
      'job:': job,
      'interest': currentUserInterest,
      'address': currentUserAddress,
      'occupation': currentoccupation,
      'likedUsername': likedUsername,
      'likedUserEmail': likedUseremail,
      'likedUserage': likedUserage,
      'likedUserImageUrls': imageurls,
      'likedUserInterests': likedUserInterest,
      'likeduserAddress': likedUserAddress,
      'likedUseroccupation': occupation,
      'matched': false,
    });
  }

  Future<void> deleteUser(id) async {
    await FirebaseFirestore.instance.collection('likeduser').doc(id).delete();
  }
}
