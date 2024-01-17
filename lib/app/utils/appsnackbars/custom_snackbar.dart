import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_text_style.dart';

class CallCustomSnackBar {
  static customSnackBar({
    required String title,
    required String message,
    bool? isSuccess = true,
  }) {
    return Get.snackbar(
      title,
      '',
      colorText: Colors.white,
      messageText: Text(
        message,
        style: AppTextStyle.poppinsRegular
            .copyWith(color: Colors.white, overflow: TextOverflow.visible),
      ),
      backgroundColor:
          isSuccess == true ? Colors.green.shade600 : Colors.red.shade600,
      duration: const Duration(milliseconds: 1500),
      snackPosition: SnackPosition.TOP,
    );
  }
}
