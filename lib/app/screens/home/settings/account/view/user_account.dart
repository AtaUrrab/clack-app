import 'package:clack_app/app/core/constant/global_variables.dart';
import 'package:clack_app/app/utils/res/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/res/app_colors.dart';
import '../../../../../utils/res/assets_refer.dart';
import '../../../../../utils/widgets/edit_text_form_field.dart';
import '../controller/user_account_controller.dart';

class UserAccountScreen extends StatelessWidget {
  const UserAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller =
    Get.put(UserAccountController());
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: GetBuilder<UserAccountController>(
        builder: (_) {
          return Stack(
            children: [
              ///for Background of Screen
              SizedBox(height: Get.height),
              Image.asset(AssetsRefer.circleBackground),
              Positioned(
                top: 600,
                left: 0,
                right: 0,
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.white,
                ),
              ),

              //App Logo in White Color
              Positioned(
                top: 60,
                left: 120,
                child: Image.asset(
                  AssetsRefer.appWhiteLogo,
                  width: Get.width * .35,
                ),
              ),

              // Setting Section
              Positioned(
                top: 140,
                left: 0,
                right: 0,
                child: Container(
                  width: Get.width,
                  height: Get.height * .65,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        blurRadius: 7,
                        spreadRadius: 2.5,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height * .02),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Account",
                          style: AppTextStyle.poppinsBold.copyWith(
                              color: AppColors.greenColor, fontSize: 16),
                        ),
                      ),
                      Text(
                        "Full Name",
                        style: AppTextStyle.poppinsSemiBold.copyWith(
                            color: AppColors.greenColor, fontSize: 13),
                      ),
                      SizedBox(height: Get.height * .01),
                      EditTextFormField(hinttext: Constant.user!.name),
                      SizedBox(height: Get.height * .04),
                      Text(
                        "user_name",
                        style: AppTextStyle.poppinsSemiBold.copyWith(
                            color: AppColors.greenColor, fontSize: 13),
                      ),
                      SizedBox(height: Get.height * .01),
                      EditTextFormField(hinttext: Constant.user!.userName),
                      SizedBox(height: Get.height * .04),
                      Text(
                        "Email",
                        style: AppTextStyle.poppinsSemiBold.copyWith(
                            color: AppColors.greenColor, fontSize: 13),
                      ),
                      SizedBox(height: Get.height * .01),
                      EditTextFormField(hinttext: Constant.user!.email),
                      SizedBox(height: Get.height * .04),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
