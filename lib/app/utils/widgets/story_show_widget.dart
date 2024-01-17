// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clack_app/app/utils/res/app_text_style.dart';
import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import 'image_progress_widget.dart';

class StoryShowWidget extends StatelessWidget {
  const StoryShowWidget({
    Key? key,
    required this.imagePath,
    this.onTap,
    this.isStoryWatched = false,
  }) : super(key: key);
  final String imagePath;
  final VoidCallback? onTap;
  final bool isStoryWatched;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(3.0),
              decoration: isStoryWatched == true
                  ? const BoxDecoration()
                  : BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border:
                          Border.all(width: 1.5, color: AppColors.greenColor),
                    ),
              child: ImageWithProgress(
                onImageTap: null,
                imagePath: imagePath,
                imageSize: isStoryWatched == true ? 60 : 55,
              ),
            ),
            Text(
              "Karen",
              style: AppTextStyle.poppinsSemiBold.copyWith(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
