// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/methods.dart';
import '../res/app_colors.dart';
import '../res/app_text_style.dart';

class UserUrlMessage extends StatelessWidget {
  const UserUrlMessage({
    Key? key,
    required this.isSender,
    required this.url,
    required this.urlImg,
    required this.urlTitle,
  }) : super(key: key);
  final bool isSender;
  final String url;
  final String urlImg;
  final String urlTitle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender == true ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          width: Get.width * .65,
          decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft:
                  isSender == true ? const Radius.circular(12) : Radius.zero,
              bottomRight:
                  isSender == true ? Radius.zero : const Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              // Url Preview and Title Section
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Expanded(child: Image.asset(urlImg)),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.greenColor.withOpacity(0.85),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          urlTitle,
                          style: AppTextStyle.poppinsRegular.copyWith(
                            overflow: TextOverflow.clip,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Url Section
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: RichText(
                  maxLines: 2,
                  text: TextSpan(
                    text: url,
                    style: AppTextStyle.poppinsRegular.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launchFileUrl(url),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
