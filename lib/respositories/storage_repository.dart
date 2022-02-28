import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tiki/respositories/base_storage_repository.dart';
import 'package:tiki/respositories/databerepository.dart';

class StorageRepository extends BaseStroageRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> uploadImage(XFile image) async {
    try {
      await storage
          .ref(_auth.currentUser!.email)
          .child(image.name)
          .putFile(File(image.path))
          .then((p0) => DatabaseRepository().updateUserPictures(image.name));
    } catch (e) {
      print(e);
    }
  }

  Future<String> getImageUrl(String imageName) async {
    String downloadUrl = await storage
        .ref("${_auth.currentUser!.email}/$imageName")
        .getDownloadURL();
    return downloadUrl;
  }
}
