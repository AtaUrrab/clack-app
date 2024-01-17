import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/res/assets_refer.dart';
import '../controller/splash_controller.dart';

class SplashSCreen extends StatelessWidget {
  const SplashSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 4, child: Container()),
            Expanded(
              flex: 4,
              child: Image.asset(
                AssetsRefer.appGreenLogo,
                width: Get.width * 0.5,
              ),
            ),
            Expanded(child: Container()),
            Image.asset(
              AssetsRefer.usersGroupLogo,
            ),
          ],
        ),
      ),
    );
  }
}
