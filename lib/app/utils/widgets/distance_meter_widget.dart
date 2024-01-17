import 'package:clack_app/app/utils/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_text_style.dart';

class DistanceMeterWidget extends StatelessWidget {
  const DistanceMeterWidget({
    Key? key,
    required this.text,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);
  final String text;
  final Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: isSelected == true ? AppColors.greenColor : Colors.white,
            width: Get.width,
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                text,
                style: AppTextStyle.poppinsMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected == true ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          const Divider(height: 0.0, thickness: 1.5),
        ],
      ),
    );
  }
}
