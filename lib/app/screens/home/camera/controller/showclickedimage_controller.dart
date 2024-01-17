import 'dart:io';

import 'package:clack_app/app/core/models/message_attachment.dart';
import 'package:clack_app/app/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../core/constant/global_variables.dart';
import '../../../../core/constant/methods.dart';
import '../../../../core/constant/methods/image_picker.dart';
import '../../../../core/models/chatroom_model.dart';
import '../../../../core/models/message_model.dart';
import '../../../../core/services/firebase/database/firestore_storage.dart';
import '../../../../core/services/firestore/firestore_service.dart';

class ShowCLickedImageController extends GetxController {
  File clickedImage = File('');
  TextEditingController captionController = TextEditingController();

  ChatRoomModel chatRoomModel = ChatRoomModel.empty();
  String chatRoomID = "";
  UserModel otherUser = UserModel.empty();
  FocusNode captionFocusNode = FocusNode();

  @override
  void onInit() {
    clickedImage = Get.arguments['imagePath'];
    chatRoomModel = Get.arguments['chatRoomModel'];
    otherUser = Get.arguments['otherUser'];

    super.onInit();
  }

  // Pick Image From gallery
  Future<void> pickImage() async {
    try {
      File? image = await imagePickerFunc(ImageSource.gallery);
      if (image == null) {
        return;
      }
      clickedImage = image;
      update();
    } catch (e) {
      return;
    }
  }

  //Picrure Send FUnction
  picSendFunc() async {
    try {
      if (chatRoomModel.id.isEmpty) {
        chatRoomID = getRandomString(20);
      }
      if (chatRoomModel.id.isNotEmpty) {
        chatRoomID = chatRoomModel.id;
      }
      String imgUrl = await FirestoreStorage.uploadMessageImg(clickedImage);
      MessageModel newMessage = MessageModel(
        id: getRandomString(20),
        createdAt: Timestamp.now(),
        message: '',
        senderId: Constant.user!.userId,
        chatRoomId: chatRoomID,
        status: "sent",
        messageAttachment: MessageAttachment(
          attachmentType: 'img',
          attachmentText: captionController.text.trim(),
          attachmentLink: imgUrl,
          attachmentSize: '',
          thumbnailUrl: '',
        ),
      );
      chatRoomModel = ChatRoomModel(
        id: chatRoomID,
        createdAt: chatRoomModel.createdAt,
        participantIds: chatRoomModel.participantIds,
        participantsList: [otherUser, Constant.user!],
        lastMessage: imgUrl,
        lastMessageID: newMessage.id,
        lastMessageTime: newMessage.createdAt,
        senderId: Constant.user!.userId,
        lastMessageType: newMessage.messageAttachment.attachmentType,
        unSeenMessage: chatRoomModel.unSeenMessage + 1,
      );

      await FirestoreService.createChatRoom(chatRoomModel).then((value) async {
        await FirestoreService.createMessage(newMessage).then((value) async {
          Get.until((route) => Get.currentRoute == AppRoutes.conversation);
          update();
        }).onError((error, stackTrace) {
          debugPrint("Firebase Error while sending Message: $error");
        });
      }).onError((error, stackTrace) {
        debugPrint("Firebase Error while creating ChatRoomModel: $error");
      });
    } on FirebaseException catch (err) {
      debugPrint(err.toString());
      return;
    }
  }

  @override
  void onClose() {
    captionController.dispose();
    super.onClose();
  }
}
