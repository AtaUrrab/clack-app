import 'dart:io';

import 'package:clack_app/app/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/res/app_colors.dart';
import '../../utils/res/app_text_style.dart';
import '../../utils/res/assets_refer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return GetBuilder<HomeController>(
      builder: (_) {
        return Scaffold(
          body: controller.screens[controller.selectedIndex],
          floatingActionButton: Padding(
            padding: controller.selectedIndex == 0
                ? const EdgeInsets.only(left: 20.0)
                : controller.selectedIndex == 2
                    ? const EdgeInsets.only(right: 20.0)
                    : const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 0.0,
                onPressed: () {},
                shape: const CircleBorder(),
                child: ImageIcon(
                  controller.selectedIndex == 0
                      ? const AssetImage(AssetsRefer.locaterIcon)
                      : controller.selectedIndex == 1
                          ? const AssetImage(AssetsRefer.chatIcon)
                          : const AssetImage(AssetsRefer.settingsIcon),
                  color: AppColors.greenColor,
                  size: 30,
                ),
              ),
            ),
          ),
          floatingActionButtonLocation: controller.selectedIndex == 0
              ? FloatingActionButtonLocation.startDocked
              : controller.selectedIndex == 1
                  ? FloatingActionButtonLocation.centerDocked
                  : FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: SizedBox(
            height: Platform.isAndroid ? Get.height * .1 : Get.height * .13,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                items: controller.navigationBarItems,
                onTap: (index) => controller.changePage(index),
                backgroundColor: AppColors.greenColor,
                currentIndex: controller.selectedIndex,
                selectedItemColor: Colors.white,
                selectedIconTheme:
                    const IconThemeData(color: AppColors.greenColor),
                unselectedIconTheme: const IconThemeData(size: 30),
                unselectedItemColor: Colors.white,
                selectedLabelStyle: AppTextStyle.poppinsSemiBold
                    .copyWith(fontSize: 15, color: Colors.white),
                unselectedLabelStyle: AppTextStyle.poppinsSemiBold
                    .copyWith(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
