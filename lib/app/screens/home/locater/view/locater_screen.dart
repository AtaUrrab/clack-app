import 'package:clack_app/app/screens/home/locater/controller/locater_controller.dart';
import 'package:clack_app/app/utils/res/app_colors.dart';
import 'package:clack_app/app/utils/res/app_text_style.dart';
import 'package:clack_app/app/utils/res/assets_refer.dart';
import 'package:clack_app/app/utils/res/strings.dart';
import 'package:clack_app/app/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaterScreen extends StatelessWidget {
  const LocaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocaterController());
    return GetBuilder<LocaterController>(builder: (_) {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(height: Get.height * .08),
            Center(
              child: Text(
                AppStrings.findFriends,
                style: AppTextStyle.poppinsBold.copyWith(fontSize: 16),
              ),
            ),
            SizedBox(height: Get.height * .01),
            Text(
              AppStrings.friendsInRadius,
              style: AppTextStyle.poppinsSemiBold
                  .copyWith(fontSize: 13, color: AppColors.darkGreyColor),
            ),
            SizedBox(height: Get.height * .05),
            Image.asset(
              AssetsRefer.locaterBackground,
              height: Get.height * .5,
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * .1),
              child: SizedBox(
                width: Get.width,
                height: Get.height * .06,
                child: AppButton(
                  onPressed: () => controller.distanceBottomSheet(),
                  text: controller.distance.isEmpty
                      ? "Distance"
                      : controller.distance,
                  isBorder: true,
                  isBackgroundGreen: false,
                ),
              ),
            ),
            SizedBox(height: Get.height * .05),
          ],
        ),
      );
    });
  }
}
