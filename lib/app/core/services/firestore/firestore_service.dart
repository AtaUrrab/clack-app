import 'package:clack_app/app/core/models/chatroom_model.dart';
import 'package:clack_app/app/core/models/message_model.dart';
import 'package:clack_app/app/utils/appdialogs/show_ok_dialog.dart';
import 'package:clack_app/app/utils/progress_indicator/custom_circular_progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

class FirestoreService {
  static Future<bool> createUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection("usersList")
          .doc(user.userId)
          .set(user.toMap());
      CustomProgressIndicator.hideProgress();
      return true;
    } on FirebaseException catch (e) {
      CustomProgressIndicator.hideProgress();
      CallOkDialog.showOSDialog(message: e.toString());
      return false;
    }
  }

  static Future<bool> createChatRoom(ChatRoomModel chatRoomModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("chatRoomsList")
          .doc(chatRoomModel.id)
          .set(chatRoomModel.toMap());
      return true;
    } on FirebaseException {
      return false;
    }
  }

  static Future<bool> createMessage(MessageModel messageModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("messages")
          .doc(messageModel.id)
          .set(messageModel.toMap());
      return true;
    } on FirebaseException {
      return false;
    }
  }

  static Future<bool> updateField(String collection, String docID,
      String fieldName, dynamic fieldValue) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(docID)
          .update({fieldName: fieldValue});
      return true;
    } on FirebaseException {
      return false;
    }
  }

  static Future<UserModel?> getCurrentUser(String uid) async {
    try {
      final user = await FirebaseFirestore.instance
          .collection("usersList")
          .doc(uid)
          .get();
      if (!user.exists) {
        return null;
      }
      return UserModel.fromMap(user.data()!);
    } on FirebaseException {
      return null;
    }
  }

  static Future<bool> deleteItem(String collection, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .delete();

      return true;
    } on FirebaseException {
      return false;
    }
  }
}
