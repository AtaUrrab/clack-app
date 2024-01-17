import 'package:firebase_auth/firebase_auth.dart';

class SignOutService {
  static Future<bool> signOut() async {
    bool isSuccess = false;
    try {
      // CustomProgressIndicator.showProgress();
      await FirebaseAuth.instance.signOut();
      // CustomProgressIndicator.hideProgress();
      isSuccess = true;
    } on FirebaseAuthException {
      // CustomProgressIndicator.hideProgress();
      // CallOkDialog.showOSDialog(message: e.toString());
      isSuccess = false;
    }
    return isSuccess;
  }
}
