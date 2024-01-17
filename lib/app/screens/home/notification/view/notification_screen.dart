import 'package:clack_app/app/core/constant/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/res/app_text_style.dart';
import '../../../../utils/widgets/freind_request_widget.dart';
import '../controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());
    return GestureDetector(
      onTap: () => controller.focusNode.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Notifications",
                    style: AppTextStyle.poppinsRegular
                        .copyWith(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: Get.height * .06),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return FriendRequestWidget(
                      user: Constant.user!,
                      onAccept: () {},
                      onReject: () {},
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
