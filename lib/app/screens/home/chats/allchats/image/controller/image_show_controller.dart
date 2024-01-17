import 'package:get/get.dart';

class UserProfileController extends GetxController {
  String userImage = '';
  String userName = '';

  @override
  void onInit() {
    userName = Get.arguments['userName'];
    userImage = Get.arguments['userImage'];
    super.onInit();
  }
}
