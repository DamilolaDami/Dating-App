// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../models/user.dart';

// class SearchRepository {
//   final FirebaseFirestore _firestore;

//   SearchRepository({required FirebaseFirestore firestore})
//       : _firestore = firestore ?? FirebaseFirestore.instance;

//   Future<User> chooseUser(currentUserId, selectedUserId, name, photoUrl) async {
//     await _firestore
//         .collection('users')
//         .doc(currentUserId)
//         .collection('chosenList')
//         .doc(selectedUserId)
//         .set({});

//     await _firestore
//         .collection('users')
//         .doc(selectedUserId)
//         .collection('chosenList')
//         .doc(currentUserId)
//         .set({});

//     await _firestore
//         .collection('users')
//         .doc(selectedUserId)
//         .collection('selectedList')
//         .doc(currentUserId)
//         .set({
//       'name': name,
//       'photoUrl': photoUrl,
//     });
//     return getUser(currentUserId);
//   }

//   passUser(currentUserId, selectedUserId) async {
//     await _firestore
//         .collection('users')
//         .doc(selectedUserId)
//         .collection('chosenList')
//         .doc(currentUserId)
//         .set({});

//     await _firestore
//         .collection('users')
//         .doc(currentUserId)
//         .collection('chosenList')
//         .doc(selectedUserId)
//         .set({});
//     return getUser(currentUserId);
//   }

//   Future getUserInterests(userId) async {
//     User currentUser = User();

//     await _firestore.collection('users').doc(userId).get().then((user) {
//       currentUser.name = user['name'];
//       currentUser.imageUrls = user['photoUrl'];
//       currentUser.gender = user['gender'];
//       currentUser.interestedIn = user['interestedIn'];
//     });
//     return currentUser;
//   }

//   Future<List> getChosenList(userId) async {
//     List<String> chosenList = [];
//     await _firestore
//         .collection('users')
//         .doc(userId)
//         .collection('chosenList')
//         .get()
//         .then((docs) {
//       for (var doc in docs.docs) {
//         if (docs.docs != null) {
//           chosenList.add(doc.id);
//         }
//       }
//     });
//     return chosenList;
//   }

//   Future<User> getUser(userId) async {
//     User _user = User();
//     List chosenList = await getChosenList(userId);
//     User currentUser = await getUserInterests(userId);

//     await _firestore.collection('users').get().then((users) {
//       for (var user in users.docs) {
//         if ((!chosenList.contains(user.id)) &&
//             (user.id != userId) &&
//             (currentUser.interestedIn == user['gender']) &&
//             (user['interestedIn'] == currentUser.gender)) {
//           _user.uid = user.id;
//           _user.name = user['name'];
//           _user.photo = user['photoUrl'];
//           _user.age = user['age'];
//           _user.location = user['location'];
//           _user.gender = user['gender'];
//           _user.interestedIn = user['interestedIn'];
//           break;
//         }
//       }
//     });

//     return _user;
//   }
// }
