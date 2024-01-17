// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clack_app/app/core/constant/methods.dart';
import 'package:clack_app/app/screens/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';

import '../../../utils/res/app_colors.dart';
import '../../../utils/res/app_text_style.dart';
import '../../../utils/res/assets_refer.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_clipper.dart';
import '../../../utils/widgets/custom_form_field.dart';
import '../../../utils/widgets/custom_tabbar.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: GetBuilder<AuthController>(
        builder: (_) {
          return GestureDetector(
            onTap: () => controller.unfocusFunc(),
            child: Stack(
              children: [
                ///for Background of Screen
                SizedBox(height: Get.height),
                Image.asset(AssetsRefer.circleBackground),
                Positioned(
                  top: 400,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: Get.height * .6,
                    width: Get.width,
                    color: Colors.white,
                  ),
                ),
                const Positioned(
                  top: 250,
                  right: -80,
                  child: Triangle(leftSideOpen: false),
                ),
                const Positioned(
                  top: 250,
                  left: -80,
                  child: Triangle(leftSideOpen: true),
                ),

                //App Logo in White Color
                Positioned(
                    top: 100,
                    left: 100,
                    child: Image.asset(AssetsRefer.appWhiteLogo)),

                // Signup and Signin UI
                Positioned(
                  top: 190,
                  left: 37,
                  right: 37,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.25),
                          blurRadius: 7,
                          spreadRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Custom Tabbar Widget
                        Row(
                          children: [
                            CustomTabbarWidget(
                              text: "Sign In",
                              isSelected: controller.selectedTab == 0,
                              onTap: () {
                                controller.selectedTab = 0;
                                controller.update();
                              },
                            ),
                            CustomTabbarWidget(
                              text: "Sign Up",
                              isSelected: controller.selectedTab == 1,
                              onTap: () {
                                controller.selectedTab = 1;
                                controller.update();
                              },
                            ),
                          ],
                        ),
                        // SizedBox(height: Get.height * .016),

                        controller.selectedTab == 0

                            // Sign In Ui
                            ? Form(
                                key: controller.signinKey,
                                child: SizedBox(
                                  height: Get.height * .45,
                                  child: ListView(
                                    physics: const ScrollPhysics(),
                                    padding: const EdgeInsets.only(top: 0),
                                    shrinkWrap: true,
                                    children: [
                                      SizedBox(height: Get.height * .02),
                                      const Text(
                                        'Email',
                                        style: AppTextStyle.poppinsSemiBold,
                                      ),
                                      SizedBox(height: Get.height * .01),
                                      CustomFormField(
                                        controller: controller.emailController,
                                        validator: (value) =>
                                            emailValidationwhole(value),
                                        focusNode:
                                            controller.signInFocusNode[0],
                                      ),
                                      SizedBox(height: Get.height * .01),
                                      const Text('Password',
                                          style: AppTextStyle.poppinsSemiBold),
                                      CustomFormField(
                                        obScureText: controller.isHide,
                                        controller:
                                            controller.passwordController,
                                        iconWidget: InkWell(
                                          onTap: () {
                                            controller.isHide =
                                                !controller.isHide;
                                            controller.update();
                                          },
                                          child: controller.isHide
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility),
                                        ),
                                        iconColor: controller.isHide
                                            ? AppColors.darkGreyColor
                                            : AppColors.greenColor,
                                        validator: (value) =>
                                            passwordValidation(value),
                                        focusNode:
                                            controller.signInFocusNode[1],
                                      ),
                                      SizedBox(height: Get.height * .01),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          'Forget Password?',
                                          style: AppTextStyle.poppinsSemiBold
                                              .copyWith(
                                                  color: AppColors.greenColor),
                                        ),
                                      ),
                                      SizedBox(height: Get.height * .01),
                                      SizedBox(
                                        width: double.infinity,
                                        height: Get.height * .06,
                                        child: AppButton(
                                          onPressed: () =>
                                              controller.signInFunc(),
                                          text: "Sign In",
                                          isTextGreen: false,
                                        ),
                                      ),
                                      SizedBox(height: Get.height * .01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 2,
                                            width: Get.width * .27,
                                            color: AppColors.greyColor,
                                          ),
                                          Text(
                                            "or",
                                            style: AppTextStyle.poppinsSemiBold
                                                .copyWith(
                                                    color: AppColors.greyColor),
                                          ),
                                          Container(
                                            height: 2,
                                            width: Get.width * .27,
                                            color: AppColors.greyColor,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height * .01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              AssetsRefer.googleIcon,
                                              width: Get.width * .1),
                                          const SizedBox(width: 10),
                                          SvgPicture.asset(
                                              AssetsRefer.appleIcon,
                                              width: Get.width * .1),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )

                            // Sign Up Ui
                            : Form(
                                key: controller.signupKey,
                                child: SizedBox(
                                  height: Get.height * .45,
                                  child: ListView(
                                    physics: const ScrollPhysics(),
                                    padding: const EdgeInsets.only(top: 0),
                                    shrinkWrap: true,
                                    children: [
                                      SizedBox(height: Get.height * .02),
                                      const Text('Name',
                                          style: AppTextStyle.poppinsSemiBold),
                                      SizedBox(height: Get.height * .01),
                                      CustomFormField(
                                        controller: controller.nameController,
                                        validator: (value) =>
                                            nameValidation(value),
                                        focusNode:
                                            controller.signUpFocusNode[0],
                                      ),
                                      SizedBox(height: Get.height * .01),
                                      const Text('Email',
                                          style: AppTextStyle.poppinsSemiBold),
                                      SizedBox(height: Get.height * .01),
                                      CustomFormField(
                                        controller: controller.emailController,
                                        validator: (value) =>
                                            emailValidationwhole(value),
                                        focusNode:
                                            controller.signUpFocusNode[1],
                                      ),
                                      SizedBox(height: Get.height * .01),
                                      const Text('Password',
                                          style: AppTextStyle.poppinsSemiBold),
                                      SizedBox(height: Get.height * .01),
                                      CustomFormField(
                                        obScureText: controller.isHide,
                                        controller:
                                            controller.passwordController,
                                        iconWidget: InkWell(
                                          onTap: () {
                                            controller.isHide =
                                                !controller.isHide;
                                            controller.update();
                                          },
                                          child: controller.isHide
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility),
                                        ),
                                        iconColor: controller.isHide
                                            ? AppColors.darkGreyColor
                                            : AppColors.greenColor,
                                        validator: (value) =>
                                            passwordValidation(value),
                                        focusNode:
                                            controller.signUpFocusNode[2],
                                      ),
                                      SizedBox(height: Get.height * .01),
                                      const Text('Confirm Password',
                                          style: AppTextStyle.poppinsSemiBold),
                                      SizedBox(height: Get.height * .01),
                                      CustomFormField(
                                        obScureText: controller.isHide,
                                        controller: controller
                                            .confirmPasswordController,
                                        validator: (value) =>
                                            confirmPasswordValidation(
                                                value,
                                                controller
                                                    .passwordController.text),
                                        focusNode:
                                            controller.signUpFocusNode[3],
                                      ),
                                      SizedBox(height: Get.height * .02),
                                      SizedBox(
                                        width: double.infinity,
                                        height: Get.height * .06,
                                        child: AppButton(
                                          onPressed: () =>
                                              controller.signUpFunc(),
                                          text: "Sign Up",
                                          isTextGreen: false,
                                        ),
                                      ),
                                      SizedBox(height: Get.height * .1),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
