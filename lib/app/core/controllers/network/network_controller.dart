import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../../utils/appdialogs/show_ok_dialog.dart';
import '../../../utils/appsnackbars/custom_snackbar.dart';
import '../../constant/global_variables.dart';

class NetworkController extends GetxController {
  bool isNotConnected = true;
  late StreamSubscription connectivityStream;

  void setConnectivitySubscription() {
    connectivityStream = Connectivity().onConnectivityChanged.listen(
          (result) => helloMethod(result),
        );
  }

  void helloMethod(ConnectivityResult result) {
    isNotConnected = result != ConnectivityResult.none;
    update();
    if (isNotConnected == true) {
      isDeviceOffline = isNotConnected;
      update();
      CallOkDialog.showOSDialog(message: "Please connect to the Internet");
      print("Network Disconect");
    } else {
      isDeviceOffline = isNotConnected;
      update();
      print("Network Connected");
      CallCustomSnackBar.customSnackBar(
          title: "Succesfull",
          message: "Your connection has been successfully reconnect");
    }
  }

  @override
  void onInit() {
    setConnectivitySubscription();
    super.onInit();
  }

  @override
  void onClose() {
    connectivityStream.cancel();
    super.onClose();
  }

  // updateConnectionStatus(ConnectivityResult res) async {
  //   // final res = await connectivity.checkConnectivity();
  //   print("Result: -------- $res");

  // }
}
