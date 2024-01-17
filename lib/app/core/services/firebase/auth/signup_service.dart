import 'package:clack_app/app/utils/progress_indicator/custom_circular_progress.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../utils/appdialogs/show_ok_dialog.dart';

class SignUpService {
  Future<UserCredential?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      CustomProgressIndicator.showProgress();
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      CustomProgressIndicator.hideProgress();
      return userCredential;
    } on FirebaseAuthException {
      CustomProgressIndicator.hideProgress();
      CallOkDialog.showOSDialog(
          message: "This email address is already use by another account");
    } catch (e) {
      CallOkDialog.showOSDialog(message: "$e");
    }
    return null;
  }
}
