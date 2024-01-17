import 'package:clack_app/app/core/services/firebase/auth/signout_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../core/constant/global_variables.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/firebase/auth/signin_service.dart';
import '../../../core/services/firebase/auth/signup_service.dart';
import '../../../core/services/firestore/firestore_service.dart';
import '../../../utils/appdialogs/show_ok_dialog.dart';
import '../../../utils/progress_indicator/custom_circular_progress.dart';

class AuthController extends GetxController {
  int selectedTab = 0;
  bool isHide = true;
  GlobalKey<FormState> signinKey = GlobalKey<FormState>();
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  final signInFocusNode = <FocusNode>[
    FocusNode(),
    FocusNode(),
  ];
  final signUpFocusNode = <FocusNode>[
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  EmailOTP emailOTP = EmailOTP();

  // On Init Func
  @override
  void onInit() {
    // signInFocusNode[0].requestFocus();
    super.onInit();
  }

  //Unfocus Function
  unfocusFunc() {
    for (var focusNode in signInFocusNode) {
      if (focusNode.hasFocus) {
        focusNode.unfocus();
      }
    }
    for (var focusNode in signUpFocusNode) {
      if (focusNode.hasFocus) {
        focusNode.unfocus();
      }
    }
  }

  // Sign Up Function
  signUpFunc() async {
    if (!signupKey.currentState!.validate()) {
      return;
    }
    // authService.signUpUser(
    //   name: nameController.text,
    //   email: emailController.text,
    //   password: passwordController.text,
    // );
    try {
      CustomProgressIndicator.showProgress();

      final credentials = await SignUpService().signUpWithEmailAndPassword(
          emailController.text.trim(), passwordController.text);
      if (credentials == null) {
        CustomProgressIndicator.hideProgress();
        return CallOkDialog.showOSDialog(
            message: "Something wrong with Signin");
      }

      final user = UserModel(
        userId: credentials.user!.uid,
        createdAt: Timestamp.now(),
        name: nameController.text.trim(),
        userName: "",
        userBio: "",
        email: emailController.text.trim(),
        token: "",
        isOnline: false,
        isVerifiedAccount: false,
        profilePicture: "",
        isSeenMessage: false,
      );

      final isSuccess = await FirestoreService.createUser(user);
      if (!isSuccess) {
        CustomProgressIndicator.hideProgress();
        return CallOkDialog.showOSDialog(
            message: "Something wrong with User Account Creation");
      }
      emailOTPFunc();
    } catch (e) {
      CustomProgressIndicator.hideProgress();
      return CallOkDialog.showOSDialog(message: "Something wrong");
    }
  }

  emailOTPFunc() async {
    try {
      emailOTP.setConfig(
        appEmail: "officialclack@gmail.com",
        appName: "Clack App",
        userEmail: emailController.text.trim(),
        otpLength: 4,
        otpType: OTPType.digitsOnly,
      );
      final res = await emailOTP.sendOTP();
      if (res == true) {
        CustomProgressIndicator.hideProgress();
        CallOkDialog.showOSDialog(
          message: "OTP has been sent",
          onTapOk: () {
            Get.offAllNamed(AppRoutes.otp, arguments: {
              "email": emailController.text.trim(),
              "password": passwordController.text.trim(),
              "emailOTP": emailOTP,
            });
          },
        );
      } else {
        CustomProgressIndicator.hideProgress();
        return CallOkDialog.showOSDialog(message: "Something wrong");
      }
    } catch (err) {
      CustomProgressIndicator.hideProgress();
      return CallOkDialog.showOSDialog(message: "Something wrong");
    }
  }

  //Sign In Function
  signInFunc() async {
    if (!signinKey.currentState!.validate()) {
      return;
    }
    CustomProgressIndicator.showProgress();
    final userCredential = await SignInService().signInWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    if (userCredential == null) {
      CustomProgressIndicator.hideProgress();
      CallOkDialog.showOSDialog(message: "Wrong Credentials !");
      return;
    }
    Constant.user =
        await FirestoreService.getCurrentUser(userCredential.user!.uid);
    debugPrint("working");
    debugPrint("Value: ${Constant.user!.isVerifiedAccount}");
    if (Constant.user!.isVerifiedAccount == true) {
      await FirestoreService.updateField(
          "usersList", userCredential.user!.uid, "isOnline", true);
      CustomProgressIndicator.hideProgress();
      Get.offAllNamed(AppRoutes.home);
    }
    if (Constant.user!.isVerifiedAccount == false) {
      CustomProgressIndicator.hideProgress();
      await SignOutService.signOut();
      Constant.user = UserModel.empty();
      CallOkDialog.showOSDialog(message: "Please Verify your account");
      return;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
