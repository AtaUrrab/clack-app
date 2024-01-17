import 'dart:developer';
import 'dart:io';

import 'package:clack_app/app/core/constant/global_variables.dart';
import 'package:clack_app/app/core/constant/methods.dart';
import 'package:clack_app/app/core/models/message_attachment.dart';
import 'package:clack_app/app/core/models/message_model.dart';
import 'package:clack_app/app/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../../../routes/app_routes.dart';
import '../../../../../../core/constant/methods/image_picker.dart';
import '../../../../../../core/models/chatroom_model.dart';
import '../../../../../../core/services/firestore/firestore_service.dart';

class ConversationController extends GetxController {
  bool isTapedField = false;
  FocusNode messagFocusNode = FocusNode();
  TextEditingController userMessageController = TextEditingController();
  int fileDownloadIndex = 0;
  int imageDownloadIndex = 0;
  ChatRoomModel chatRoomModel = ChatRoomModel.empty();

  String otherUserID = "";
  List<MessageModel> messagesList = [];
  UserModel otherUserModel = UserModel.empty();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String lastDisplayedDate = '';

  // On Init Function
  @override
  onInit() {
    getValuesFunc();
    super.onInit();
  }

  getValuesFunc() {
    chatRoomModel = Get.arguments['chatRoomModel'];

    for (var element in chatRoomModel.participantIds) {
      if (element != Constant.user!.userId) {
        otherUserID = element;
      }
    }
    debugPrint("Chat Room Model ID: ${chatRoomModel.id}");
  }

  // Back Screen Function
  backScreenFunction() async {
    if (isDeviceOffline == true) {
      log("Offline Back");
      Get.back();
    }
    try {
      if (messagesList.isEmpty) {
        log("Empty");
        await FirestoreService.deleteItem("chatRoomsList", chatRoomModel.id)
            .then((value) async {
          Get.back();
        });
      } else {
        log("Online Back");
        Get.back();
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  //Other User Stream
  Stream<DocumentSnapshot<Map<String, dynamic>>> otherUserStream() {
    return FirebaseFirestore.instance
        .collection("usersList")
        .doc(otherUserID)
        .snapshots();
  }

  // Mesage Stream
  Stream<QuerySnapshot<Map<String, dynamic>>> messageStream() {
    return FirebaseFirestore.instance
        .collection("messages")
        .where('chatRoomId', isEqualTo: chatRoomModel.id)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  String timeDisplayMethod(Timestamp timestamp) {
    final currentTime = DateTime.now();
    final messageTime = timestamp.toDate();

    if (isSameDay(currentTime, messageTime)) {
      return 'Today';
    } else if (isSameDay(
        currentTime.subtract(const Duration(days: 1)), messageTime)) {
      return 'Yesterday';
    } else {
      final diffDays = currentTime.difference(messageTime).inDays;
      if (diffDays <= 7) {
        return DateFormat('EEEE').format(messageTime);
      } else {
        return DateFormat('EEE, MMM d').format(messageTime);
      }
    }
  }

  bool isSameDay(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day;
  }

  // For Unfocus Form Field
  onTapChatScreen() {
    messagFocusNode.unfocus();
    isTapedField = false;
    update();
  }

  // File Download Function
  fileDownloadFunc() async {
    fileDownloadIndex = 1;
    update();
    await Future.delayed(const Duration(seconds: 1));
    fileDownloadIndex = 2;
    update();
  } // File Download Function

  // Image Download Func
  imageDownloadFunc(String name, String img) async {
    try {
      if (imageDownloadIndex == 0) {
        imageDownloadIndex = 1;
        update();
        await Future.delayed(const Duration(seconds: 1));
        imageDownloadIndex = 2;
        update();
        return;
      }
      if (imageDownloadIndex == 2) {
        Get.toNamed(
          AppRoutes.userProfileShowScreen,
          arguments: {
            "userName": name,
            "userImage": img,
          },
        );
      }
    } catch (e) {
      return;
    }
  }

  // Message Send Function
  sendMessage() async {
    try {
      String trimMsg = userMessageController.text.trim();
      String messageType = '';
      if (trimMsg == '') return;
      final result = UrlValidator(trimMsg).isValidUrl();
      if (result == true) {
        messageType = 'url';
      }
      if (result == false) {
        messageType = 'text';
      }
      MessageModel newMessage = MessageModel(
        id: getRandomString(20),
        createdAt: Timestamp.now(),
        message: trimMsg,
        senderId: Constant.user!.userId,
        chatRoomId: chatRoomModel.id,
        status: "sent",
        messageAttachment: MessageAttachment.empty(),
      );

      chatRoomModel = ChatRoomModel(
        id: chatRoomModel.id,
        createdAt: chatRoomModel.createdAt,
        participantIds: [otherUserID, Constant.user!.userId],
        participantsList: [otherUserModel, Constant.user!],
        lastMessage: trimMsg,
        lastMessageID: newMessage.id,
        lastMessageTime: newMessage.createdAt,
        senderId: Constant.user!.userId,
        lastMessageType: messageType,
        unSeenMessage: chatRoomModel.unSeenMessage + 1,
      );

      uploadDataFunc(newMessage);
    } catch (err) {
      debugPrint("Error: $err");
      return;
    }
  }

  //Upload Data into Firebase Function
  uploadDataFunc(MessageModel message) async {
    try {
      userMessageController.clear();

      await FirestoreService.createChatRoom(chatRoomModel).then((value) async {
        await FirestoreService.createMessage(message).then((value) async {
          update();
        }).onError((error, stackTrace) {
          debugPrint("Firebase Error while sending Message: $error");
        });
      }).onError((error, stackTrace) {
        debugPrint("Firebase Error while creating ChatRoomModel: $error");
      });
    } catch (err) {
      debugPrint("Error: $err");
      return;
    }
  }

  // On Tap Camera Icon
  onTapCameraIcon() {
    messagFocusNode.unfocus();
    Get.toNamed(
      AppRoutes.cameraScreen,
      arguments: {"chatRoomModel": chatRoomModel, 'otherUser': otherUserModel},
    );
  }

  // On Tap Gallery Icon
  onTapGalleryIcon() async {
    try {
      File? image = await imagePickerFunc(ImageSource.gallery);
      if (image == null) {
        return;
      }
      Get.toNamed(
        AppRoutes.showClickedImageScreen,
        arguments: {
          "imagePath": image,
          "chatRoomModel": chatRoomModel,
          'otherUser': otherUserModel
        },
      );
    } catch (e) {
      return;
    }
  }

  // On Close
  @override
  void onClose() {
    userMessageController.dispose();
    messagFocusNode.unfocus();
    super.onClose();
  }
}
