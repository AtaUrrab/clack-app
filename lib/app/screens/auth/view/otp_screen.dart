import 'package:clack_app/app/screens/auth/controller/otp_controller.dart';
import 'package:clack_app/app/utils/res/app_colors.dart';
import 'package:clack_app/app/utils/res/app_text_style.dart';
import 'package:clack_app/app/utils/res/strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/res/assets_refer.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_clipper.dart';
import '../../../utils/widgets/otp_text_field.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController());
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: GetBuilder<OtpController>(
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
                        vertical: 25, horizontal: 20),
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
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "Please check email ",
                              style: AppTextStyle.poppinsSemiBold.copyWith(
                                  color: AppColors.darkGreyColor, fontSize: 11),
                              children: [
                                TextSpan(text: controller.userEmail),
                                const TextSpan(
                                    text: " to see the verification code")
                              ]),
                        ),
                        SizedBox(height: Get.height * .05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            controller.controllers.length,
                            (index) => SizedBox(
                              width: Get.width * .15,
                              child: OtpTextField(
                                keyboardType: TextInputType.number,
                                focusNode: controller.otpFocusNode[index],
                                controller: controller.controllers[index],
                                onChanged: (value) =>
                                    controller.onOtpChanged(value, index),
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * .03),
                        RichText(
                          text: TextSpan(
                            text: AppStrings.codeMsg,
                            style: AppTextStyle.poppinsSemiBold,
                            children: [
                              TextSpan(
                                text: "Resend",
                                style: AppTextStyle.poppinsSemiBold
                                    .copyWith(color: AppColors.greenColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => controller.resendOTPFunc(),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: Get.height * .01),
                        // RichText(
                        //   text: TextSpan(
                        //     text: AppStrings.restMsg,
                        //     style: StyleRefer.poppinsSemiBold,
                        //     children: [
                        //       TextSpan(
                        //         text: controller.timerText,
                        //         style: StyleRefer.poppinsSemiBold
                        //             .copyWith(color: AppColors.greenColor),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: Get.height * .03),
                        SizedBox(
                            width: double.infinity,
                            height: Get.height * .06,
                            child: AppButton(
                              onPressed: () => controller.onVerifyFunc(),
                              text: "Verify",
                              isTextGreen: false,
                            ))
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
