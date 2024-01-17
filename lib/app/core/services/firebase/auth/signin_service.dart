import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../utils/appdialogs/show_ok_dialog.dart';
import '../../../../utils/progress_indicator/custom_circular_progress.dart';

class SignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException {
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      CustomProgressIndicator.showProgress();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        CustomProgressIndicator.hideProgress();
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredentials = await _auth.signInWithCredential(credential);
      CustomProgressIndicator.hideProgress();
      return userCredentials;
    } on FirebaseAuthException catch (e) {
      CustomProgressIndicator.hideProgress();
      CallOkDialog.showOSDialog(message: e.toString());
    }
    return null;
  }
}
