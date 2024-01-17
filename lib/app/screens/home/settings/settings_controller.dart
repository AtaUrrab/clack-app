import 'package:clack_app/app/utils/appdialogs/custom_dialog.dart';
import 'package:clack_app/app/utils/appdialogs/show_ok_dialog.dart';
import 'package:clack_app/app/utils/progress_indicator/custom_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../core/constant/global_variables.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/firebase/auth/signout_service.dart';
import '../../../core/services/firestore/firestore_service.dart';

class SettingsController extends GetxController {
  // AuthService authService = AuthService();

  // logout function
  logoutFunc() {
    CallAlertDialog.showOSDialog(
      title: "Come back soon!",
      okText: "Logout",
      onOkTap: logoutMethod,
      dialogContent: const Text("Are you sure you want to logout?"),
    );
  }

  logoutMethod() async {
    try {
      Get.back();
      CustomProgressIndicator.showProgress();
      await FirestoreService.updateField(
        "usersList",
        Constant.user!.userId,
        "isOnline",
        false,
      );
      await SignOutService.signOut();
      await Future.delayed(const Duration(milliseconds: 500));
      Constant.user = UserModel.empty();
      CustomProgressIndicator.hideProgress();
      Get.offAllNamed(AppRoutes.auth);
    } catch (err) {
      CustomProgressIndicator.hideProgress();
      CallOkDialog.showOSDialog(message: "Error to Logout");
      return;
    }
  }
}
