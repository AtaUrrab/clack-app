import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';
import '../widgets/custom_button.dart';

// Call Dialog Function
class CallOkDialog {
  static Future showOSDialog({
    required String message,
    VoidCallback? onTapOk,
  }) async {
    await showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return PopScope(
          canPop:
              //  () async =>
              false,
          child: OkDialog(
            message: message,
            onTapOk: onTapOk ?? () => Get.back(),
          ),
        );
      },
    );
  }
}

// Alert Dialog Widget
class OkDialog extends StatelessWidget {
  const OkDialog({
    super.key,
    required this.message,
    required this.onTapOk,
  });
  final String message;
  final VoidCallback onTapOk;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(message),
      titleTextStyle: AppTextStyle.poppinsRegular.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.visible),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      contentTextStyle: AppTextStyle.poppinsRegular.copyWith(
        fontSize: 13,
        color: AppColors.darkGreyColor,
        overflow: TextOverflow.visible,
      ),
      actions: [
        AppButton(
          onPressed: onTapOk,
          text: "Ok",
          isTextGreen: false,
          isRadiusRound: false,
        )
        // TextButton(
        //   onPressed: () => Get.back(),
        //   child: Text(
        //     "Ok",
        //     style: StyleRefer.poppinsRegular
        //         .copyWith(fontSize: 14, color: AppColors.greenColor),
        //   ),
        // ),
      ],
    );
  }
}
