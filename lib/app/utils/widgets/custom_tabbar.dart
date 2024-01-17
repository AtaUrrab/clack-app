import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';

class CustomTabbarWidget extends StatelessWidget {
  const CustomTabbarWidget({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
  });
  final String text;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Text(
              text,
              style: AppTextStyle.poppinsBold.copyWith(
                fontSize: 15,
                color: isSelected ? AppColors.greenColor : AppColors.greyColor,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 3,
            color: isSelected ? AppColors.greenColor : AppColors.greyColor,
          ),
        ],
      ),
    );
  }
}
