import 'package:clack_app/app/screens/home/contactedit/controller/contact_edit_controller.dart';
import 'package:clack_app/app/utils/res/app_colors.dart';
import 'package:clack_app/app/utils/res/app_text_style.dart';
import 'package:clack_app/app/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/widgets/edit_text_form_field.dart';

class ContactEditScreen extends StatelessWidget {
  const ContactEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactEditController());
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Edit Contact",
                  style: AppTextStyle.poppinsRegular
                      .copyWith(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: Get.height * .06),
              Text(
                "Full Name",
                style: AppTextStyle.poppinsSemiBold
                    .copyWith(color: AppColors.greenColor, fontSize: 13),
              ),
              SizedBox(height: Get.height * .01),
              EditTextFormField(hinttext: controller.userModel.name),
              SizedBox(height: Get.height * .04),
              Text(
                "user_name",
                style: AppTextStyle.poppinsSemiBold
                    .copyWith(color: AppColors.greenColor, fontSize: 13),
              ),
              SizedBox(height: Get.height * .01),
              EditTextFormField(hinttext: controller.userModel.userName),
              SizedBox(height: Get.height * .04),
              Text(
                "Email",
                style: AppTextStyle.poppinsSemiBold
                    .copyWith(color: AppColors.greenColor, fontSize: 13),
              ),
              SizedBox(height: Get.height * .01),
              EditTextFormField(hinttext: controller.userModel.email),
              SizedBox(height: Get.height * .04),
              SizedBox(
                height: Get.height * .05,
                width: double.infinity,
                child: AppButton(
                  onPressed: () {},
                  text: "Save",
                  isTextGreen: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
