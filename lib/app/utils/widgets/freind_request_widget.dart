import 'package:flutter/material.dart';

import '../../core/models/user_model.dart';
import '../res/app_colors.dart';
import '../res/app_text_style.dart';
import 'custom_button.dart';
import 'image_progress_widget.dart';

class FriendRequestWidget extends StatelessWidget {
  const FriendRequestWidget({
    Key? key,
    required this.user,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  final UserModel user;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      padding: const EdgeInsets.only(
        left: 10.0,
        top: 10.0,
        bottom: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.25),
            blurRadius: 3.0,
            spreadRadius: 1.5,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          ImageWithProgress(
            onImageTap: () {},
            imagePath: user.profilePicture,
            imageSize: 40,
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: AppTextStyle.poppinsSemiBold.copyWith(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Want's to follow you",
                  style: AppTextStyle.poppinsRegular
                      .copyWith(fontSize: 14, color: AppColors.darkGreyColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
            child: AppButton(
              onPressed: onAccept,
              text: "Accept",
              isTextGreen: false,
            ),
          ),
          IconButton(
            onPressed: onReject,
            icon: const Icon(
              Icons.close,
              color: AppColors.greyColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
