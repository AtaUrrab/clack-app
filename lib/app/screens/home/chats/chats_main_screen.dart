// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clack_app/app/screens/home/chats/allcalls/view/all_calls_screen.dart';
import 'package:clack_app/app/screens/home/chats/allgroups/view/all_groups_screen.dart';
import 'package:clack_app/app/utils/res/app_text_style.dart';
import 'package:clack_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/widgets/text_buttom.dart';
import 'allchats/all_chats_screen.dart';
import 'chats_main_screen_controller.dart';

class ChatsMainScreen extends StatelessWidget {
  const ChatsMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatsMainScreenController());

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Chats",
            style: AppTextStyle.poppinsBold.copyWith(fontSize: 30),
          ),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(AppRoutes.notificationScreen),
              icon: Stack(
                children: [
                  const Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.black,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => Get.toNamed(AppRoutes.addFriendsScreen),
              icon: const Icon(
                Icons.person_add,
                size: 30,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 30,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: GetBuilder<ChatsMainScreenController>(builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              children: [
                SizedBox(height: Get.height * .02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButtonWidget(
                        text: "Message",
                        isSelected: controller.selectedWidgetIndex == 0,
                        onTap: () {
                          controller.selectedWidgetIndex = 0;
                          controller.update();
                        },
                      ),
                      TextButtonWidget(
                        text: "Groups",
                        isSelected: controller.selectedWidgetIndex == 1,
                        onTap: () {
                          controller.selectedWidgetIndex = 1;
                          controller.update();
                        },
                      ),
                      TextButtonWidget(
                        text: "Calls",
                        isSelected: controller.selectedWidgetIndex == 2,
                        onTap: () {
                          controller.selectedWidgetIndex = 2;
                          controller.update();
                        },
                      ),
                    ],
                  ),
                ),
                if (controller.selectedWidgetIndex == 0)
                  const Expanded(child: AllChatsScreen()),
                if (controller.selectedWidgetIndex == 1)
                  const Expanded(child: AllGroupsScreen()),
                if (controller.selectedWidgetIndex == 2)
                  const Expanded(child: AllCallsScreen()),
              ],
            ),
          );
        }));
  }
}
