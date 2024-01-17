import 'package:clack_app/app/utils/progress_indicator/custom_circular_progress.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../core/constant/global_variables.dart';
import '../../../core/services/firebase/auth/signin_service.dart';
import '../../../core/services/firestore/firestore_service.dart';
import '../../../utils/appdialogs/show_ok_dialog.dart';

class OtpController extends GetxController {
  String userEmail = '';
  String userPass = "";
  String enteredOTP = '';
  // int remainingTime = 60;
  // String timerText = '01:00';
  final otpFocusNode = <FocusNode>[
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  EmailOTP emailOTP = EmailOTP();

  // Unfocus Function
  unfocusFunc() {
    for (var focusNode in otpFocusNode) {
      if (focusNode.hasFocus) {
        focusNode.unfocus();
      }
    }
  }

  // Function to move focus to the next field as the user enters a digit
  void _moveToNextField(int index) {
    if (index < otpFocusNode.length - 1) {
      otpFocusNode[index].unfocus();
      FocusScope.of(Get.context!).requestFocus(otpFocusNode[index + 1]);
    }
  }

  // Function to handle changes in the OTP text fields
  void onOtpChanged(String value, int index) {
    if (value.length <= 1) {
      controllers[index].text = value;
    } else {
      controllers[index].text = value.substring(0, 1);
    }

    if (value.isNotEmpty) {
      _moveToNextField(index);
    }
  }

  @override
  void onInit() {
    helperFunc();
    super.onInit();
  }

  // Helper Function
  helperFunc() async {
    userEmail = Get.arguments['email'];
    userPass = Get.arguments['password'];
    emailOTP = Get.arguments['emailOTP'];
    update();
    // updateTimer();
  }

  // // Timer Update Function
  // updateTimer() async {
  //   if (remainingTime > 0) {
  //     remainingTime--;
  //     int minutes = remainingTime ~/ 60;
  //     int seconds = remainingTime % 60;
  //     timerText =
  //         '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  //     update();
  //     Timer(const Duration(seconds: 1), updateTimer);
  //     if (remainingTime == 0) {
  //       timerText = '00:00';
  //       update();
  //       return;
  //     }
  //   }
  // }

  // Verify Click
  onVerifyFunc() async {
    CustomProgressIndicator.showProgress();
    // Concatenate the OTP from all controllers
    enteredOTP = controllers.map((controller) => controller.text).join();
    final res = await emailOTP.verifyOTP(otp: enteredOTP);
    if (res == true) {
      final userCredential =
          await SignInService().signInWithEmailAndPassword(userEmail, userPass);
      if (userCredential == null) {
        CustomProgressIndicator.hideProgress();
        CallOkDialog.showOSDialog(message: "Wrong Credentials !");
        return;
      }
      await FirestoreService.updateField(
          "usersList", userCredential.user!.uid, "isVerifiedAccount", true);
      Constant.user =
          await FirestoreService.getCurrentUser(userCredential.user!.uid);
      CustomProgressIndicator.hideProgress();
      Get.offAllNamed(AppRoutes.home);
    } else {
      CustomProgressIndicator.hideProgress();
      CallOkDialog.showOSDialog(message: "Invalid OTP");
      return;
    }
  }

  // Resend OTP Function
  resendOTPFunc() {
    // remainingTime = 60;
    // updateTimer();
  }
}
