import 'package:clack_app/app/screens/home/chats/allgroups/controller/all_groups_controller.dart';
import 'package:clack_app/app/utils/res/app_text_style.dart';
import 'package:clack_app/app/utils/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/res/app_colors.dart';
import '../../../../../utils/res/assets_refer.dart';

class AllGroupsScreen extends StatelessWidget {
  const AllGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllGroupsController());
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: Get.height * .13),
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
            onTap: () => controller.addFriendsScreen(),
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
