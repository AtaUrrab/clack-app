import 'package:clack_app/app/core/constant/global_variables.dart';
import 'package:clack_app/app/core/models/chatroom_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/user_model.dart';

class ContactEditController extends GetxController {
  UserModel userModel = UserModel.empty();
  ChatRoomModel chatRoomModel = ChatRoomModel.empty();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    setValue();
    super.onInit();
  }

  setValue() {
    chatRoomModel = Get.arguments['chatRoomModel'];
    for (var element in chatRoomModel.participantsList) {
      if (element.userId != Constant.user!.userId) {
        userModel = element;
        break;
      }
    }
  }
}
