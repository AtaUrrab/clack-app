// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clack_app/app/utils/res/app_colors.dart';
import 'package:clack_app/app/utils/widgets/image_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../core/constant/global_variables.dart';
import '../../../utils/res/app_text_style.dart';
import '../../../utils/res/assets_refer.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: GetBuilder<SettingsController>(
        builder: (_) {
          return Stack(
            children: [
              ///for Background of Screen
              SizedBox(height: Get.height),
              Image.asset(AssetsRefer.circleBackground),
              Positioned(
                top: 600,
                left: 0,
                right: 0,
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.white,
                ),
              ),

              //App Logo in White Color
              Positioned(
                top: 60,
                left: 120,
                child: Image.asset(
                  AssetsRefer.appWhiteLogo,
                  width: Get.width * .35,
                ),
              ),

              // Setting Section
              Positioned(
                top: 130,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    // User Image
                    ImageWithProgress(
                      onImageTap: () {},
                      imagePath: Constant.user!.profilePicture,
                      imageSize: 100,
                    ),
                    SizedBox(height: Get.height * .02),

                    // User Name
                    Text(
                      Constant.user!.name,
                      style: AppTextStyle.poppinsBold.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    // User Email
                    Text(
                      Constant.user!.email,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.poppinsRegular.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(height: Get.height * .02),
                    // Settings Options
                    Container(
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            blurRadius: 7,
                            spreadRadius: 2.5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomListTileWidget(
                            icon: AssetsRefer.profileIconOutlined,
                            title: "Account",
                            description: "user_name, change email adress",
                            onTap: () {
                              Get.toNamed(AppRoutes.userAccountScreen);
                            },
                          ),
                          const DividerWidget(),
                          CustomListTileWidget(
                            icon: AssetsRefer.privacyIconOutlined,
                            title: "Privacy",
                            description:
                                "Block contacts, Add. Fingerprint & FaceLock",
                            onTap: () {},
                          ),
                          const DividerWidget(),
                          CustomListTileWidget(
                            icon: AssetsRefer.chatsIconOutlined,
                            title: "Chats",
                            description: "Theme, wallpapers, chat history",
                            onTap: () {},
                          ),
                          const DividerWidget(),
                          CustomListTileWidget(
                            icon: AssetsRefer.profileIconOutlined,
                            title: "Invite Friend",
                            description: "Refer to your friend",
                            onTap: () {},
                          ),
                          const DividerWidget(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextButton.icon(
                              onPressed: () => controller.logoutFunc(),
                              icon: const ImageIcon(
                                AssetImage(
                                  AssetsRefer.logoutIconOutlined,
                                ),
                                color: Colors.red,
                                size: 25,
                              ),
                              label: Text(
                                "Logout",
                                style: AppTextStyle.poppinsMedium.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    this.onTap,
  }) : super(key: key);
  final String icon;
  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 13.0),
        child: Row(
          children: [
            ImageIcon(
              AssetImage(icon),
              color: Colors.black,
              size: 30,
            ),
            const SizedBox(width: 7.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.visible,
                    style: AppTextStyle.poppinsRegular
                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description,
                    style: AppTextStyle.poppinsRegular
                        .copyWith(color: AppColors.darkGreyColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1.5,
      height: 0.0,
      color: AppColors.greyColor,
    );
  }
}
