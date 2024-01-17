import 'package:firebase_auth/firebase_auth.dart';

import '../../../../utils/appdialogs/show_ok_dialog.dart';
import '../../../../utils/progress_indicator/custom_circular_progress.dart';

class ForgetPasswordService {
  Future<bool> forgetPassword(String email) async {
    try {
      CustomProgressIndicator.showProgress();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      CustomProgressIndicator.hideProgress();
      return true;
    } on FirebaseAuthException catch (e) {
      CustomProgressIndicator.hideProgress();
      CallOkDialog.showOSDialog(message: e.toString());
      return false;
    }
  }
}
