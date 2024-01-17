// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clack_app/app/core/models/chatroom_model.dart';
import 'package:clack_app/app/utils/res/app_colors.dart';
import 'package:clack_app/app/utils/res/app_text_style.dart';
import 'package:clack_app/app/utils/res/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/global_variables.dart';
import '../../../../utils/appdialogs/custom_dialog.dart';
import '../../../../utils/res/assets_refer.dart';
import '../../../../utils/widgets/moreoptions_widget.dart';

class AllChatsController extends GetxController {
  RxBool isBlocked = false.obs;
  bool isHideChat = false;

  // Story ViewFunction
  storyViewFunc() {}

  Stream<QuerySnapshot<Map<String, dynamic>>> chatRoomStream() {
    return FirebaseFirestore.instance
        .collection("chatRoomsList")
        .where("participantIds", arrayContains: Constant.user!.userId)
        .orderBy("lastMessageTime", descending: true)
        .snapshots();
  }

  List<ChatRoomModel> chatListMethod(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    List<ChatRoomModel> chatRoomList = snapshot.data?.docs
            .map((map) => ChatRoomModel.fromMap(map.data()))
            .toList() ??
        [];
    return chatRoomList;
  }

  // At More Pressed
  onMorePressedFunc() {
    return showModalBottomSheet(
      context: Get.context!,
      elevation: 0.0,
      backgroundColor: Colors.green,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(25.0), right: Radius.circular(25.0)),
      ),
      constraints: BoxConstraints.expand(
        height: Get.height * .34,
      ),
      builder: (context) {
        return GetBuilder<AllChatsController>(
          builder: (_) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9.0),
                  child: Text(
                    "More Options",
                    style: AppTextStyle.poppinsBold
                        .copyWith(fontSize: 15, color: Colors.white),
                  ),
                ),
                const Divider(height: 0.0, thickness: 1.5),
                MoreOptionsWidget(
                  text: "Block",
                  icon: Icons.block,
                  onTap: () => onBlockFunc(),
                ),
                // const Divider(height: 0.0, thickness: 1.5),

                const Divider(height: 0.0, thickness: 1.5),
                isHideChat == false
                    ? MoreOptionsWidget(
                        text: "Hide Chat",
                        icon: Icons.visibility,
                        onTap: () => onhideUnhidePressed(),
                      )
                    : MoreOptionsWidget(
                        text: "Unhide Chat",
                        icon: Icons.visibility_off,
                        onTap: () => onhideUnhidePressed(),
                      ),
                const Divider(height: 0.0, thickness: 1.5),
                MoreOptionsWidget(
                  text: "Password",
                  icon: Icons.lock,
                  onTap: () => onTapPassword(context),
                ),
                const Divider(height: 0.0, thickness: 1.5),
                Expanded(child: Container(color: Colors.white))
              ],
            );
          },
        );
      },
    );
  }

  // On Pressed Tap
  onBlockFunc() {
    isBlocked.value = false;
    return CallAlertDialog.showOSDialog(
      title: "Block rubazjamshaid@gmail.com?",
      onOkTap: () {},
      dialogContent: SizedBox(
        height: Get.height * .19,
        width: Get.width,
        child: Column(
          children: [
            const Text(AppStrings.blockText),
            const SizedBox(height: 20),
            Row(
              children: [
                Obx(() => InkWell(
                      onTap: () {
                        isBlocked.value = !isBlocked.value;
                        update();
                      },
                      child: Icon(
                        isBlocked.value
                            ? Icons.check_box_sharp
                            : Icons.check_box_outline_blank_outlined,
                        color: isBlocked.value ? AppColors.greenColor : null,
                        size: 30,
                      ),
                    )),
                const SizedBox(width: 15),
                Text(
                  "Report Contact",
                  style: AppTextStyle.poppinsRegular
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const Text(AppStrings.forwardText),
          ],
        ),
      ),
    );
  }

  // On Pressed Password
  onTapPassword(BuildContext context) {
    return CallAlertDialog.showOSDialog(
      title: "Password",
      onOkTap: () {},
      dialogContent: SizedBox(
        height: Get.height * .15,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const ImageIcon(
                AssetImage(AssetsRefer.lockIcon),
                size: 35,
                color: AppColors.greenColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                width: 1,
                height: 70,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const ImageIcon(
                AssetImage(AssetsRefer.faceLockIcon),
                size: 35,
                color: AppColors.greenColor,
              ),
            ),
          ],
        ),
      ),
      isDefaultButtons: false,
      actionsBtton: [
        InkWell(
          onTap: () => Get.back(),
          child: Center(
            child: Text(
              "Set Your Passcode",
              style: AppTextStyle.poppinsSemiBold
                  .copyWith(fontSize: 14, color: AppColors.greenColor),
            ),
          ),
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: () => Get.back(),
          child: Center(
            child: Text(
              "Set Your Face ID",
              style: AppTextStyle.poppinsSemiBold
                  .copyWith(fontSize: 14, color: AppColors.greenColor),
            ),
          ),
        ),
      ],
    );
  }

  // On Press Hide/ Unhide Pressed
  onhideUnhidePressed() {
    isHideChat = !isHideChat;
    update();
  }

  // At Archive Pressed
  onArchivePressedFunc() {
    //
  }
}
