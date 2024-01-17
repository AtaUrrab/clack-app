// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';

class MoreOptionsWidget extends StatelessWidget {
  const MoreOptionsWidget({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTextStyle.poppinsRegular
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Icon(
              icon,
              size: 30,
              color: AppColors.greenColor,
            )
          ],
        ),
      ),
    );
  }
}
