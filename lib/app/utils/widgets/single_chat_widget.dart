// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clack_app/app/core/constant/global_variables.dart';
import 'package:clack_app/app/core/models/chatroom_model.dart';
import 'package:clack_app/app/core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_routes.dart';
import '../res/app_colors.dart';
import '../res/app_text_style.dart';
import 'image_progress_widget.dart';

class SingleChatWidget extends StatelessWidget {
  const SingleChatWidget({
    Key? key,
    required this.chatRoomModel,
    required this.onMorePressed,
    required this.onArchivePressed,
  }) : super(key: key);

  final ChatRoomModel chatRoomModel;
  final void Function(BuildContext) onMorePressed;
  final void Function(BuildContext) onArchivePressed;

  @override
  Widget build(BuildContext context) {
    UserModel otherUser = UserModel.empty();

    for (var element in chatRoomModel.participantsList) {
      if (element.userId != Constant.user!.userId) {
        otherUser = element;
      }
    }

    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.conversation, arguments: {
          "chatRoomModel": chatRoomModel,
        });
      },
      child: Slidable(
        endActionPane: ActionPane(
          dragDismissible: false,
          extentRatio: 0.4,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              flex: 2,
              backgroundColor: AppColors.greyColor,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              icon: Icons.more_horiz,
              foregroundColor: Colors.white,
              label: "More",
              onPressed: onMorePressed,
            ),
            SlidableAction(
              flex: 2,
              backgroundColor: AppColors.greenColor,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              icon: Icons.archive_sharp,
              foregroundColor: Colors.white,
              label: "Archive",
              onPressed: onArchivePressed,
            ),
          ],
        ),
        startActionPane: ActionPane(
          dragDismissible: false,
          extentRatio: 0.23,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
                flex: 2,
                backgroundColor: AppColors.greenColor,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                icon: Icons.person,
                foregroundColor: Colors.white,
                label: "Edit Name",
                onPressed: (context) {
                  Get.toNamed(
                    AppRoutes.contactEditScreen,
                    arguments: {"chatRoomModel": chatRoomModel},
                  );
                }),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            children: [
              SizedBox(width: Get.width * .02),
              Container(
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(width: 1.5, color: AppColors.greenColor),
                ),
                child: ImageWithProgress(
                  onImageTap: () => Get.toNamed(
                    AppRoutes.userProfileShowScreen,
                    arguments: {
                      "userName": otherUser.name,
                      "userImage": otherUser.profilePicture,
                    },
                  ),
                  imagePath: otherUser.profilePicture,
                  imageSize: 55,
                ),
              ),
              SizedBox(width: Get.width * .03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      otherUser.name,
                      style:
                          AppTextStyle.poppinsSemiBold.copyWith(fontSize: 15),
                    ),

                    //if user received audio recording
                    if (chatRoomModel.lastMessageType == 'audio')
                      Row(
                        children: [
                          const Icon(
                            Icons.mic,
                            color: AppColors.greenColor,
                            size: 18,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            "0:14",
                            overflow: TextOverflow.visible,
                            style: AppTextStyle.poppinsSemiBold.copyWith(
                                fontSize: 12, color: AppColors.darkGreyColor),
                          ),
                        ],
                      ),

                    //if user received a photo
                    if (chatRoomModel.lastMessageType == 'img')
                      Row(
                        children: [
                          const Icon(
                            Icons.photo,
                            color: AppColors.darkGreyColor,
                            size: 18,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            "Photo",
                            overflow: TextOverflow.visible,
                            style: AppTextStyle.poppinsSemiBold.copyWith(
                                fontSize: 12, color: AppColors.darkGreyColor),
                          ),
                        ],
                      ),

                    //if user received video file
                    if (chatRoomModel.lastMessageType == 'video')
                      Row(
                        children: [
                          const Icon(
                            Icons.videocam,
                            color: AppColors.darkGreyColor,
                            size: 18,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            "Video",
                            overflow: TextOverflow.visible,
                            style: AppTextStyle.poppinsSemiBold.copyWith(
                                fontSize: 12, color: AppColors.darkGreyColor),
                          ),
                        ],
                      ),

                    //if user received  'word','pdf','doc',  file
                    if (chatRoomModel.lastMessageType == 'word' ||
                        chatRoomModel.lastMessageType == 'pdf' ||
                        chatRoomModel.lastMessageType == 'doc')
                      Row(
                        children: [
                          const Icon(
                            Icons.description,
                            color: AppColors.darkGreyColor,
                            size: 18,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            "file",
                            overflow: TextOverflow.visible,
                            style: AppTextStyle.poppinsSemiBold.copyWith(
                                fontSize: 12, color: AppColors.darkGreyColor),
                          ),
                        ],
                      ),

                    //if user received simple text
                    if (chatRoomModel.lastMessageType == 'text' ||
                        chatRoomModel.lastMessageType == 'url')
                      Text(
                        chatRoomModel.lastMessage,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.poppinsSemiBold.copyWith(
                            fontSize: 12, color: AppColors.darkGreyColor),
                      ),
                  ],
                ),
              ),
              SizedBox(width: Get.width * .02),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        DateFormat("h:m a")
                            .format(chatRoomModel.lastMessageTime.toDate()),
                        style: AppTextStyle.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          color: chatRoomModel.unSeenMessage > 0 &&
                                  chatRoomModel.senderId !=
                                      Constant.user!.userId
                              ? AppColors.greenColor
                              : AppColors.darkGreyColor,
                        ),
                      ),
                      SizedBox(width: Get.width * .01),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: chatRoomModel.unSeenMessage > 0 &&
                                chatRoomModel.senderId != Constant.user!.userId
                            ? AppColors.greenColor
                            : AppColors.darkGreyColor,
                        size: 20,
                      ),
                    ],
                  ),
                  if (chatRoomModel.unSeenMessage > 0 &&
                      chatRoomModel.senderId != Constant.user!.userId)
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Text(
                        "${chatRoomModel.unSeenMessage}",
                        style: AppTextStyle.poppinsSemiBold
                            .copyWith(fontSize: 11, color: Colors.white),
                      ),
                    )
                ],
              ),
              SizedBox(width: Get.width * .01),
            ],
          ),
        ),
      ),
    );
  }
}
