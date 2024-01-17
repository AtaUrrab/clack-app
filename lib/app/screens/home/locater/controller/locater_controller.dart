import 'package:clack_app/app/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/res/app_colors.dart';
import '../../../../utils/res/app_text_style.dart';
import '../../../../utils/res/strings.dart';
import '../../../../utils/widgets/distance_meter_widget.dart';

class LocaterController extends GetxController {
  RxBool getStarted = false.obs;
  String distance = "100 meter";
  List<String> diaMeterList = [
    '100 meter',
    '200 meter',
    '300 meter',
    '400 meter',
  ];

  // Init Function
  @override
  void onInit() {
    distanceBottomSheet();
    super.onInit();
  }

  // Bottom Sheet for Distance
  distanceBottomSheet() async {
    await Future.delayed(const Duration(milliseconds: 0));
    return showModalBottomSheet(
      context: Get.context!,
      elevation: 0.0,
      backgroundColor: AppColors.greenColor,
      useSafeArea: true,
      constraints: BoxConstraints.expand(
        height: Get.height * .4,
        width: Get.width,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.0),
          topRight: Radius.circular(35.0),
        ),
      ),
      builder: (context) {
        return Obx(
          () => getStarted.value == false
              ? Column(
                  children: [
                    SizedBox(height: Get.height * .05),
                    Text(
                      AppStrings.findFriends,
                      style: AppTextStyle.poppinsBold
                          .copyWith(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: Get.height * .04),
                    Text(
                      AppStrings.friensNearby,
                      style: AppTextStyle.poppinsSemiBold
                          .copyWith(fontSize: 13, color: Colors.white),
                    ),
                    SizedBox(height: Get.height * .04),
                    SizedBox(
                      width: Get.width * .7,
                      height: Get.height * .06,
                      child: AppButton(
                        onPressed: () {
                          getStarted.value = !getStarted.value;
                          update();
                        },
                        text: "Get Started",
                        isBackgroundGreen: false,
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9.0),
                      child: Text(
                        "Distance",
                        style: AppTextStyle.poppinsBold
                            .copyWith(fontSize: 15, color: Colors.white),
                      ),
                    ),
                    Container(
                      color: Colors.amber,
                      child: ListView.builder(
                        physics: const ScrollPhysics(),
                        itemCount: diaMeterList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return DistanceMeterWidget(
                            text: diaMeterList[index],
                            isSelected: distance == diaMeterList[index],
                            onTap: () {
                              distance = diaMeterList[index];
                              update();
                              Get.back();
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(child: Container(color: Colors.white)),
                  ],
                ),
        );
      },
    );
  }
}
