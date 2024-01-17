// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clack_app/app/core/models/message_model.dart';
import 'package:clack_app/app/core/models/user_model.dart';
import 'package:clack_app/app/screens/home/chats/allchats/coversation/controller/converation_controller.dart';
import 'package:clack_app/app/utils/res/app_text_style.dart';
import 'package:clack_app/app/utils/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/res/app_colors.dart';
import '../../../../../../utils/res/assets_refer.dart';
import '../../../../../../utils/widgets/image_progress_widget.dart';
import '../../../../../../utils/widgets/message_widget.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConversationController());
    return GetBuilder<ConversationController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 4.0,
            backgroundColor: AppColors.newGrey,
            flexibleSpace: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => controller.backScreenFunction(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.greenColor,
                      ),
                    ),
                    StreamBuilder(
                      stream: controller.otherUserStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const SizedBox();
                        }
                        controller.otherUserModel =
                            UserModel.fromMap(snapshot.data!.data()!);
                        return Row(
                          children: [
                            ImageWithProgress(
                              onImageTap: () {},
                              imagePath:
                                  controller.otherUserModel.profilePicture,
                              imageSize: 40,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.otherUserModel.name,
                                  style: AppTextStyle.poppinsSemiBold
                                      .copyWith(fontSize: 16),
                                  overflow: TextOverflow.visible,
                                ),
                                controller.otherUserModel.isOnline == false
                                    ? Text(
                                        "Offline",
                                        style:
                                            AppTextStyle.poppinsMedium.copyWith(
                                          fontSize: 14,
                                          color: AppColors.darkGreyColor,
                                        ),
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            "Active Now",
                                            style: AppTextStyle.poppinsMedium
                                                .copyWith(
                                              fontSize: 14,
                                              color: AppColors.darkGreyColor,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Container(
                                            height: 8,
                                            width: 8,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.greenColor),
                                          )
                                        ],
                                      ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.call,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.videocam_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              StreamBuilder(
                stream: controller.messageStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData ||
                      snapshot.data == null) {
                    return const Expanded(child: Offstage());
                  }

                  controller.messagesList = snapshot.data!.docs
                      .map((doc) => MessageModel.fromMap(doc.data()))
                      .toList();

                  return Expanded(
                    child: InkWell(
                      onTap: () => controller.onTapChatScreen(),
                      child: ListView.builder(
                        reverse: true,
                        itemCount: controller.messagesList.length,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        itemBuilder: (context, index) {
                          MessageModel message = controller.messagesList[index];
                          String timeDisplay =
                              controller.timeDisplayMethod(message.createdAt);

                          final bool isFirstMessage = index == 0;
                          final bool isDateChanged = !isFirstMessage &&
                              !controller.isSameDay(
                                controller.messagesList[index - 1].createdAt
                                    .toDate(),
                                message.createdAt.toDate(),
                              );

                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Column(
                              children: [
                                if (isFirstMessage || isDateChanged)
                                  Text(
                                    timeDisplay,
                                    style: AppTextStyle.poppinsRegular.copyWith(
                                      overflow: TextOverflow.clip,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                MessageWidget(messageModel: message),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),

              // Message Text Field Section
              Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: Get.width,
                        child: CustomFormField(
                          hinttext: "Type here",
                          isBorderEnabled: true,
                          maxLines: 6,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          controller: controller.userMessageController,
                          focusNode: controller.messagFocusNode,
                          onTap: () {
                            controller.isTapedField = true;
                            controller.update();
                          },
                        ),
                      ),
                    ),
                    IconButton(
                        padding: const EdgeInsets.only(left: 10.0),
                        onPressed: () =>
                            controller.userMessageController.text.isNotEmpty
                                ? controller.sendMessage()
                                : null,
                        icon: const Center(
                          child: Icon(
                            Icons.send_rounded,
                            color: AppColors.greenColor,
                            size: 35,
                          ),
                        ))
                  ],
                ),
              ),
              controller.isTapedField
                  ? Container(
                      width: Get.width,
                      decoration: BoxDecoration(color: Colors.grey.shade400),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Camera Icon
                          IconButton(
                            onPressed: () => controller.onTapCameraIcon(),
                            icon: const Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),

                          // Gallery Icon
                          IconButton(
                            onPressed: () => controller.onTapGalleryIcon(),
                            icon: const ImageIcon(
                              AssetImage(AssetsRefer.galleryIcon),
                              color: Colors.black,
                            ),
                          ),

                          // Doc attachment Icon
                          IconButton(
                            onPressed: () {},
                            icon: const ImageIcon(
                              AssetImage(AssetsRefer.attachmentIcon),
                              color: Colors.black,
                            ),
                          ),

                          // Location Icon
                          IconButton(
                            onPressed: () {},
                            icon: const ImageIcon(
                              AssetImage(AssetsRefer.locationIcon),
                              color: Colors.black,
                            ),
                          ),

                          // Recording Icon
                          IconButton(
                            onPressed: () {},
                            icon: const ImageIcon(
                              AssetImage(AssetsRefer.recordingIcon),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(height: Get.height * .01),
            ],
          ),
        );
      },
    );
  }
}
