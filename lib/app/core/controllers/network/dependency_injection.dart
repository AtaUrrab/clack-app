import 'package:clack_app/app/core/controllers/network/network_controller.dart';
import 'package:get/get.dart';

class DependencyInjecion {
  static void init() {
    // final controller =
    Get.put(NetworkController(), permanent: true);
    // controller.update();
    // controller.onInit();
  }
}
