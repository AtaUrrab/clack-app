import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../res/app_colors.dart';
import '../res/app_text_style.dart';
import '../res/assets_refer.dart';
import '../res/strings.dart';

class EmptyMessageWidget extends StatelessWidget {
  const EmptyMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(height: Get.height * .03),
          Image.asset(
            AssetsRefer.peopleImage,
            width: Get.width * .7,
          ),
          SizedBox(height: Get.height * .03),
          Text(
            AppStrings.emptyChatMessage,
            style: AppTextStyle.poppinsMedium.copyWith(
              color: AppColors.darkGreyColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Get.height * .03),
          InkWell(
            onTap: () => Get.toNamed(AppRoutes.addFriendsScreen),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsRefer.cloudBackground),
                ),
              ),
              child: Text(
                "Add Friends",
                style: AppTextStyle.poppinsBold.copyWith(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: Get.height * .03),
        ],
      ),
    );
  }
}
