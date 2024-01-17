import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../constant/global_variables.dart';

class FirestoreStorage {
  static Future<String> uploadMessageImg(File filePath) async {
    final String path =
        'chatImages/${Constant.user?.userId}/${Timestamp.now().millisecondsSinceEpoch}';
    Reference firestore = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = firestore.putFile(filePath);
    TaskSnapshot snapshot = await uploadTask;
    final imgURL = await snapshot.ref.getDownloadURL();
    return imgURL;
  }
}
