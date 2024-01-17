// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Text(
              text,
              style: AppTextStyle.poppinsSemiBold.copyWith(
                  color: isSelected
                      ? AppColors.greenColor
                      : AppColors.darkGreyColor),
            ),
            const SizedBox(width: 3),
            isSelected
                ? Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.circular(50)),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
