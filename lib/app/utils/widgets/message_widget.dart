import 'package:clack_app/app/core/constant/global_variables.dart';
import 'package:clack_app/app/core/models/message_attachment.dart';
import 'package:clack_app/app/core/models/message_model.dart';
import 'package:clack_app/app/utils/widgets/image_progress_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../core/constant/methods.dart';
import '../res/app_colors.dart';
import '../res/app_text_style.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.messageModel});

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    final res = Constant.user!.userId == messageModel.senderId;
    return Align(
      alignment: res == true ? Alignment.topRight : Alignment.topLeft,
      child: Column(
        crossAxisAlignment:
            res == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // if user Sned/Receive Text Message
          if (messageModel.messageAttachment == MessageAttachment.empty())
            TextMessage(messageModel: messageModel),

          // if user Sned/Receive Image Message
          if (messageModel.messageAttachment.attachmentType == 'img')
            ImageMessage(messageModel: messageModel),

          // if user Sned/Receive Url Message
          if (messageModel.messageAttachment.attachmentType == 'url')
            UrlMessage(messageModel: messageModel),

          // Message Status
          // SelectableText(
          //   "${ == true ? 'seen' : 'sent'} ${DateFormat("h:m a").format(messageModel.createdAt.toDate())}",
          //   style: StyleRefer.poppinsRegular.copyWith(
          //     overflow: TextOverflow.clip,
          //     fontSize: 12,
          //     color: Colors.black.withOpacity(.4),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class UrlMessage extends StatelessWidget {
  const UrlMessage({super.key, required this.messageModel});

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RichText(
        maxLines: 2,
        text: TextSpan(
          text: messageModel.message,
          style: AppTextStyle.poppinsRegular.copyWith(
            fontSize: 16,
            color: Colors.white,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchFileUrl(messageModel.message),
        ),
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({super.key, required this.messageModel});

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    final res = Constant.user!.userId == messageModel.senderId;
    return Container(
      constraints: BoxConstraints(minWidth: 50, maxWidth: Get.width * .8),
      decoration: BoxDecoration(
        color: res == true ? AppColors.greenColor : Colors.white,
        border: Border.all(color: AppColors.greenColor, width: 2.0),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: res == true ? const Radius.circular(16) : Radius.zero,
          bottomRight: res == true ? Radius.zero : const Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SelectableText(
          messageModel.message,
          style: AppTextStyle.poppinsRegular.copyWith(
            overflow: TextOverflow.clip,
            fontSize: 16,
            color: res == true ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    super.key,
    required this.messageModel,
  });

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * .5,
      padding: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.greenColor,
        border: Border.all(color: AppColors.greenColor, width: 2.0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: ImageWithProgress(
              onImageTap: () => Get.toNamed(
                AppRoutes.userProfileShowScreen,
                arguments: {
                  "userName": '',
                  "userImage": messageModel.messageAttachment.attachmentLink,
                },
              ),
              imagePath: messageModel.messageAttachment.attachmentLink,
              imageSize: Get.height * .25,
              fullImageScreen: true,
            ),
          ),
          if (messageModel.messageAttachment.attachmentText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 7,
              ),
              child: Text(
                messageModel.messageAttachment.attachmentText,
                style: AppTextStyle.poppinsRegular.copyWith(
                  overflow: TextOverflow.visible,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            )
        ],
      ),
    );
  }
}
