// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';

class UserDocumentMessage extends StatelessWidget {
  const UserDocumentMessage({
    Key? key,
    required this.userImg,
    required this.isSender,
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
              // Doc FileIcon and DocName Section
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.description,
                      size: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        docName,
                        style: AppTextStyle.poppinsRegular.copyWith(
                          overflow: fileDownloadIndex == 2
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    fileDownloadIndex == 0
                        ? IconButton(
                            padding: const EdgeInsets.all(0),
                            iconSize: 30,
                            onPressed: onPressed,
                            icon: const Icon(
                              Icons.download_for_offline_sharp,
                              color: Colors.white,
                            ),
                          )
                        : fileDownloadIndex == 1
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  padding: const EdgeInsets.all(1),
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              )
                            : const Offstage(),
                    const SizedBox(width: 5),
                  ],
                ),
              ),

              // Doc Size and Time Section
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
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      height: 3,
                      width: 3,
                      decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Text(
                    docFileType,
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
      ),
    );
  }
}
