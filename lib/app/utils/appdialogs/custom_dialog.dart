import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';

// Call Dialog Function
class CallAlertDialog {
  static Future showOSDialog({
    required String title,
    required Widget dialogContent,
    bool? isDefaultButtons,
    String? cancelText,
    String? okText,
    VoidCallback? onCancelTap,
    VoidCallback? onOkTap,
    List<Widget>? actionsBtton,
  }) async {
    await showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return PopScope(
          canPop:
              //  () async =>
              false,
          child: CustomDialog(
            title: title,
            dialogContent: dialogContent,
            isDefaultButtons: isDefaultButtons ?? true,
            actionsBtton: actionsBtton,
            onCancelTap: onCancelTap ?? () => Get.back(),
            cancelText: cancelText ?? "Cancel",
            onOkTap: onOkTap ?? () {},
            okText: okText ?? "Block",
          ),
        );
      },
    );
  }
}

// Alert Dialog Widget
class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.dialogContent,
    this.isDefaultButtons = true,
    this.cancelText,
    this.okText,
    required this.onCancelTap,
    required this.onOkTap,
    this.actionsBtton,
  });
  final String title;
  final Widget dialogContent;
  final bool isDefaultButtons;
  final String? cancelText, okText;
  final VoidCallback onCancelTap, onOkTap;
  final List<Widget>? actionsBtton;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(child: Text(title)),
      titleTextStyle: AppTextStyle.poppinsRegular
          .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      contentTextStyle: AppTextStyle.poppinsRegular.copyWith(
        fontSize: 13,
        color: AppColors.darkGreyColor,
        overflow: TextOverflow.visible,
      ),
      content: dialogContent,
      actions: isDefaultButtons == false
          ? actionsBtton
          : [
              TextButton(
                onPressed: onCancelTap,
                child: Text(
                  "$cancelText",
                  style: AppTextStyle.poppinsRegular
                      .copyWith(fontSize: 14, color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: onOkTap,
                child: Text(
                  "$okText",
                  style: AppTextStyle.poppinsRegular
                      .copyWith(fontSize: 14, color: AppColors.greenColor),
                ),
              ),
            ],
    );
  }
}
