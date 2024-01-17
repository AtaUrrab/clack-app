import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../res/app_colors.dart';
import '../res/app_text_style.dart';

class MyStoryWidget extends StatelessWidget {
  const MyStoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.storyViewScreen);
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.greyColor.withOpacity(.8),
            radius: 32,
            child: Icon(
              Icons.add,
              size: 50,
              color: AppColors.darkGreyColor.withOpacity(.5),
            ),
          ),
          Text(
            "Your Story",
            style: AppTextStyle.poppinsSemiBold
                .copyWith(fontSize: 12, color: AppColors.darkGreyColor),
          )
        ],
      ),
    );
  }
}
