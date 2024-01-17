import 'package:clack_app/app/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../core/constant/global_variables.dart';
import '../../../core/database/shared_preferences.dart';
import '../../../core/services/firebase/auth/signout_service.dart';
import '../../../core/services/firestore/firestore_service.dart';

class SplashScreenController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // AuthService authService = AuthService();

  @override
  void onInit() {
    // authService.getUserData();
    // awaitFunc();
    checkUser();
    super.onInit();
  }

  // void awaitFunc() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //   Get.offAllNamed(AppRoutes.auth);
  // }

  Future<void> checkUser() async {
    await LocalData.initSharedPreferences();
    if (_auth.currentUser == null) {
      Constant.user = UserModel.empty();
      await Future.delayed(const Duration(seconds: 3));
      Get.offAllNamed(AppRoutes.auth);
      return;
    }
    Constant.user =
        await FirestoreService.getCurrentUser(_auth.currentUser!.uid);
    if (Constant.user!.isVerifiedAccount == false) {
      SignOutService.signOut();
      await Future.delayed(const Duration(seconds: 3));
      Get.offAllNamed(AppRoutes.auth);
      return;
    }

    Get.offAllNamed(AppRoutes.home);
    return;
  }
}
