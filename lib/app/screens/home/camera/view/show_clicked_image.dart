import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/res/app_colors.dart';
import '../../../../utils/res/app_text_style.dart';
import '../../../../utils/widgets/custom_icon_button.dart';
import '../controller/showclickedimage_controller.dart';

class ShowCLickedImageScreen extends StatelessWidget {
  const ShowCLickedImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShowCLickedImageController());
    return GestureDetector(
      onTap: () {
        controller.captionFocusNode.unfocus();
      },
      child: GetBuilder<ShowCLickedImageController>(
        builder: (_) {
          return Scaffold(
            body: Container(
              height: Get.height,
              width: Get.width,
              color: Colors.black,
              child: Stack(
                children: [
                  Center(
                    child: Image.file(
                      controller.clickedImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: Get.height * .07,
                    child: SizedBox(
                      width: Get.width,
                      child: Row(
                        children: [
                          CustomIconButton(
                              icon: Icons.close, onTap: () => Get.back()),
                          const Expanded(child: SizedBox()),
                          CustomIconButton(
                              icon: Icons.crop_rotate, onTap: () {}),
                          CustomIconButton(
                              icon: Icons.sticky_note_2_rounded, onTap: () {}),
                          CustomIconButton(
                              icon: Icons.text_fields_rounded, onTap: () {}),
                          CustomIconButton(icon: Icons.edit, onTap: () {}),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    child: Container(
                      width: Get.width,
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () => controller.pickImage(),
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 3.0),
                              child: Icon(
                                Icons.add_photo_alternate_rounded,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SizedBox(
                              width: Get.width * .7,
                              child: TextFormField(
                                minLines: 1,
                                maxLines: 4,
                                controller: controller.captionController,
                                focusNode: controller.captionFocusNode,
                                keyboardType: TextInputType.text,
                                textAlignVertical: TextAlignVertical.center,
                                style: AppTextStyle.poppinsMedium.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.darkGreyColor,
                                  hintText: "Add a caption...",
                                  hintStyle: AppTextStyle.poppinsMedium
                                      .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 13.0, horizontal: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: InkWell(
                              onTap: () => {},
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  // color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white, width: 3.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Center(
                                  child: Text(
                                    "1",
                                    style: AppTextStyle.poppinsExtraBold
                                        .copyWith(
                                            color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    child: SizedBox(
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 3.0,
                                horizontal: 10.0,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.darkGreyColor,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Text(
                                controller.otherUser.name,
                                style: AppTextStyle.poppinsMedium.copyWith(
                                    color: Colors.white, fontSize: 13),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: IconButton(
                                padding: const EdgeInsets.only(left: 10.0),
                                icon: const Center(
                                  child: Icon(
                                    Icons.send_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                onPressed: () => controller.picSendFunc(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
