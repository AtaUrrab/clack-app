// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clack_app/app/utils/res/assets_refer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';

class UserFileMessage extends StatelessWidget {
  const UserFileMessage({
    Key? key,
    required this.userImg,
    required this.isSender,
    required this.isDocPdf,
    required this.docName,
    required this.docFileSize,
    required this.docMBSize,
    required this.docFileType,
    required this.docdate,
    required this.fileDownloadIndex,
    this.onPressed,
  }) : super(key: key);
  final String userImg;
  final bool isSender;
  final bool isDocPdf;
  final String docName;
  final String docFileSize;
  final String docMBSize;
  final String docFileType;
  final String docdate;
  final int fileDownloadIndex;
  final void Function()? onPressed;

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
              // Doc Preview Section
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: fileDownloadIndex == 0
                      ? IconButton(
                          onPressed: onPressed,
                          icon: const Icon(
                            Icons.download_for_offline_sharp,
                            size: 50,
                            color: AppColors.greenColor,
                          ),
                        )
                      : fileDownloadIndex == 1
                          ? const CircularProgressIndicator(
                              strokeWidth: 2.5,
                              backgroundColor: AppColors.greenColor,
                            )
                          : Text(
                              "Doc Preview",
                              style: AppTextStyle.poppinsRegular.copyWith(
                                overflow: TextOverflow.clip,
                                fontSize: 16,
                              ),
                            ),
                ),
              ),

              // Doc detail Section
              Row(
                children: [
                  // Doc Icon
                  isDocPdf == true
                      ? SvgPicture.asset(
                          AssetsRefer.pdfIcon,
                          width: 30,
                        )
                      : SvgPicture.asset(
                          AssetsRefer.wordIcon,
                          width: 30,
                        ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Doc Name and type in LowerCase
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: docName,
                            style: AppTextStyle.poppinsRegular.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            children: [
                              const TextSpan(text: "."),
                              TextSpan(
                                  text: docFileType.toLowerCase(),
                                  style: const TextStyle(
                                      overflow: TextOverflow.visible)),
                            ],
                          ),
                        ),

                        // Doc Size & type in SmallCase and Time
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: docFileSize,
                                style: AppTextStyle.poppinsRegular.copyWith(
                                  overflow: TextOverflow.clip,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                children: [
                                  const TextSpan(text: " "),
                                  TextSpan(text: docMBSize),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Container(
                                height: 18,
                                width: 1.5,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              docFileType.toUpperCase(),
                              style: AppTextStyle.poppinsRegular.copyWith(
                                overflow: TextOverflow.clip,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Text(
                              docdate,
                              style: AppTextStyle.poppinsRegular.copyWith(
                                overflow: TextOverflow.clip,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
