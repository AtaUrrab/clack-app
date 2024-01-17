// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clack_app/app/utils/res/app_colors.dart';
import 'package:flutter/material.dart';

import '../res/app_text_style.dart';

class SecondFormFieldWidget extends StatelessWidget {
  const SecondFormFieldWidget({
    Key? key,
    this.controller,
    this.keyboardType,
    this.focusNode,
    this.maxLines,
    this.minLines,
    this.validator,
    this.onChanged,
    this.hintText,
  }) : super(key: key);
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      focusNode: focusNode,
      style: AppTextStyle.poppinsMedium.copyWith(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: hintText,
        hintStyle: AppTextStyle.poppinsMedium.copyWith(
          color: AppColors.darkGreyColor,
          fontSize: 12,
        ),
      ),
    );
  }
}
