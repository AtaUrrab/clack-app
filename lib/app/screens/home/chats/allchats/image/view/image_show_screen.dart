import 'package:clack_app/app/utils/widgets/image_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/res/app_text_style.dart';
import '../controller/image_show_controller.dart';

class UserProfileShowScreen extends StatelessWidget {
  const UserProfileShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserProfileController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white, size: 20),
        centerTitle: false,
        title: Text(
          controller.userName,
          style: AppTextStyle.poppinsMedium
              .copyWith(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            height: Get.height * .2,
          ),
          SizedBox(
            height: Get.height * .4,
            child: ImageWithProgress(
              onImageTap: () {},
              imagePath: controller.userImage,
              imageSize: double.infinity,
              fullImageScreen: true,
            ),
          ),
        ],
      ),
    );
  }
}
