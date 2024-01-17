import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';

class ImageWithProgress extends StatelessWidget {
  const ImageWithProgress({
    super.key,
    required this.onImageTap,
    required this.imagePath,
    required this.imageSize,
    this.fullImageScreen = false,
    this.progresSize,
  });

  final Function()? onImageTap;
  final String imagePath;
  final double imageSize;
  final bool fullImageScreen;
  final double? progresSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onImageTap,
      child: SizedBox(
        height: imageSize,
        width: imageSize,
        child: imagePath.isEmpty
            ? Container(
                height: imageSize,
                width: imageSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.greenColor, // Placeholder color
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: fullImageScreen == false
                        ? Get.height * .045
                        : Get.height * .25,
                    color: Colors.white, // Icon color
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: imagePath,
                placeholder: (context, url) => _buildPlaceholder(),
                errorWidget: (context, url, error) => _buildPlaceholder(),
                imageBuilder: (context, imageProvider) =>
                    _buildImage(imageProvider),
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _buildImage(ImageProvider<Object> imageProvider) {
    return Container(
      decoration: BoxDecoration(
        shape: fullImageScreen == false ? BoxShape.circle : BoxShape.rectangle,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: imageSize,
      width: imageSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.greenColor, // Placeholder color
      ),
      child: const Center(
        child: Icon(
          Icons.person,
          size: 35.0,
          color: Colors.white, // Icon color
        ),
      ),
    );
  }
}
