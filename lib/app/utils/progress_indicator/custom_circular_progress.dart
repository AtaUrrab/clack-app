//******************
import 'dart:io';

import 'package:clack_app/app/utils/res/app_colors.dart';
import 'package:clack_app/app/utils/res/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appsnackbars/custom_snackbar.dart';

class CustomProgressIndicator {
  static bool isAlreadyShow = false;

  // Show progress Funciton
  static showProgress() {
    if (isAlreadyShow) {
      return;
    }
    isAlreadyShow = true;
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
              buttonPadding: EdgeInsets.zero,
              title: Container(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const NativeProgress(),
                    const SizedBox(width: 20),
                    Text(
                      "Loading...",
                      style: AppTextStyle.poppinsSemiBold.copyWith(
                        fontSize: 20,
                        color: AppColors.greenColor,
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  // Hide progress Funciton
  static hideProgress() {
    try {
      if (isAlreadyShow) {
        isAlreadyShow = false;
        Navigator.pop(Get.context!);
      }
    } catch (e) {
      CallCustomSnackBar.customSnackBar(title: "Error", message: e.toString());
    }
  }
}

class NativeProgress extends StatelessWidget {
  const NativeProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? const Center(
            child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
              color: AppColors.greenColor,
            ),
          ))
        : const Center(
            child: CupertinoActivityIndicator(
            color: AppColors.greenColor,
            radius: 18.0,
          ));
  }
}
