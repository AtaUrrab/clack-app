import 'package:clack_app/app/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../constant/global_variables.dart';
import '../../services/firestore/firestore_service.dart';

class UserController extends GetxController {
  final _authUser = FirebaseAuth.instance.currentUser;
  UserModel? user;
  @override
  void onInit() {
    user = Constant.user;
    super.onInit();
  }

  updateUserState(UserModel newUser) {
    user = newUser;
    update();
  }

  getUserData() async {
    Constant.user = await FirestoreService.getCurrentUser(_authUser!.uid);
    update();
  }
}
