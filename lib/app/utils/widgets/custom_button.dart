// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isBackgroundGreen = true,
    this.isTextGreen = true,
    this.isBorder = false,
    this.isRadiusRound = true,
  }) : super(key: key);
  final void Function() onPressed;
  final String text;
  final bool isBackgroundGreen;
  final bool isBorder;
  final bool isTextGreen;
  final bool isRadiusRound;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        backgroundColor:
            isBackgroundGreen ? AppColors.greenColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: isRadiusRound == true
              ? BorderRadius.circular(25.0)
              : BorderRadius.circular(8.0),
          side: isBorder
              ? const BorderSide(
                  color: AppColors.greenColor,
                  width: 1.5,
                )
              : BorderSide.none,
        ),
      ),
      child: Text(
        text,
        style: !isBorder
            ? AppTextStyle.poppinsSemiBold.copyWith(
                fontSize: 16,
                color: isTextGreen ? AppColors.greenColor : Colors.white,
              )
            : AppTextStyle.poppinsSemiBold.copyWith(
                color: AppColors.greenColor,
                fontSize: 15,
              ),
      ),
    );
  }
}
