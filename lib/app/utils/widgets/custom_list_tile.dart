import 'package:clack_app/app/utils/widgets/image_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.email,
    this.onTap,
  }) : super(key: key);

  final String imagePath;
  final String name;
  final String email;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: ImageWithProgress(
        onImageTap: () {},
        imagePath: imagePath,
        imageSize: 40,
      ),
      title: Text(name,
          style: AppTextStyle.poppinsSemiBold.copyWith(fontSize: 15)),
      subtitle: Text(
        email,
        style: AppTextStyle.poppinsMedium.copyWith(
            fontSize: 13,
            color: AppColors.darkGreyColor,
            overflow: TextOverflow.visible),
      ),
      trailing: InkWell(
        onTap: onTap,
        child: Container(
          width: Get.width * .23,
          height: Get.height * .05,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.message,
                  size: 20,
                  color: Colors.white,
                ),
                Text(
                  "Chat",
                  style: AppTextStyle.poppinsSemiBold
                      .copyWith(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
