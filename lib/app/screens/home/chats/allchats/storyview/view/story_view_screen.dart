import 'package:clack_app/app/screens/home/chats/allchats/storyview/controller/story_view_controller.dart';
import 'package:clack_app/app/utils/widgets/image_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryViewScreen extends StatelessWidget {
  const StoryViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoryViewController());
    return Scaffold(
      backgroundColor: Colors.black,
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
