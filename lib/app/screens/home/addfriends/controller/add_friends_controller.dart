import 'package:clack_app/app/core/models/chatroom_model.dart';
import 'package:clack_app/app/core/models/user_model.dart';
import 'package:clack_app/app/utils/appdialogs/show_ok_dialog.dart';
import 'package:clack_app/app/utils/progress_indicator/custom_circular_progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../core/constant/global_variables.dart';
import '../../../../core/constant/methods.dart';
import '../../../../core/services/firestore/firestore_service.dart';

class AddFriendsController extends GetxController {
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  Rx<UserModel?> searchedUser = Rx<UserModel?>(null);
  ChatRoomModel chatRoomModel = ChatRoomModel.empty();

  int tapIndex = 0;

  void onSearchFunc() async {
    focusNode.unfocus();
    final searchTerm = searchController.text.trim();
    chatRoomModel = ChatRoomModel.empty();

    if (searchTerm.isNotEmpty) {
      searchedUser.value = await searchUserByEmail(searchTerm);
      update();
    } else {
      searchedUser.value = null;
    }
  }

  Future<UserModel?> searchUserByEmail(String email) async {
    try {
      CustomProgressIndicator.showProgress();
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('usersList')
          .where('email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        final res = UserModel.fromMap(
            userSnapshot.docs.first.data() as Map<String, dynamic>);

        CustomProgressIndicator.hideProgress();
        fetchChatRoom(res);
        return res;
      } else {
        CustomProgressIndicator.hideProgress();
        CallOkDialog.showOSDialog(message: "This account does not exist");
        return null;
      }
    } catch (e) {
      CustomProgressIndicator.hideProgress();
      debugPrint('Error searching user by email: $e');
      CallOkDialog.showOSDialog(message: "Error searching user by email");
      return null;
    }
  }

  void fetchChatRoom(UserModel userModel) async {
    QuerySnapshot chatRoomSnapshot = await FirebaseFirestore.instance
        .collection("chatRoomsList")
        .where("participant", arrayContains: Constant.user!.userId)
        .orderBy("createdAt", descending: true)
        .get();

    if (chatRoomSnapshot.docs.isNotEmpty) {
      final chatRoomsList = chatRoomSnapshot.docs.map((doc) {
        return ChatRoomModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      for (var i = 0; i < chatRoomsList.length; i++) {
        if (chatRoomsList[i].participantIds.contains(userModel.userId)) {
          if (chatRoomsList[i].participantIds.contains(Constant.user!.userId)) {
            final chatRoom = chatRoomsList[i];
            chatRoomModel = chatRoom;
            update();
            debugPrint("ChatRoom: $chatRoomModel");
          }
        }
      }
    } else {
      debugPrint("ChatRoomModel Empty");
      return null;
    }
  }

  onChatTap() async {
    if (chatRoomModel.id.isNotEmpty) {
      debugPrint("Not Empty");
      Get.toNamed(AppRoutes.conversation,
          arguments: {"chatRoomModel": chatRoomModel});
    } else {
      debugPrint("Empty");
      await setValues();
    }
  }

  Future<void> setValues() async {
    chatRoomModel = ChatRoomModel(
      id: getRandomString(20),
      createdAt: Timestamp.now(),
      participantIds: [searchedUser.value!.userId, Constant.user!.userId],
      participantsList: [searchedUser.value!, Constant.user!],
      lastMessage: "",
      lastMessageID: "",
      lastMessageTime: Timestamp.now(),
      senderId: '',
      lastMessageType: "",
      unSeenMessage: 0,
    );

    await firebaseFunc();
  }

  Future<void> firebaseFunc() async {
    debugPrint("$chatRoomModel");

    await FirestoreService.createChatRoom(chatRoomModel).then((value) async {
      Get.toNamed(AppRoutes.conversation, arguments: {
        "chatRoomModel": chatRoomModel,
      });
    }).onError((error, stackTrace) {
      debugPrint("Firebase Error while creating ChatRoomModel: $error");
      CallOkDialog.showOSDialog(
        message: "Firebase Error while Creating ChatRoomModel",
      );
    });
  }
}
