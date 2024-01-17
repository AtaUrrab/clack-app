import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    this.hinttext,
    this.obScureText = false,
    this.validator,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.focusNode,
    this.iconWidget,
    this.iconColor,
    this.onTap,
    this.isBorderEnabled = false,
    this.maxLines = 1,
    this.minLines,
  }) : super(key: key);

  final String? hinttext;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obScureText;
  final FocusNode? focusNode;
  final Widget? iconWidget;
  final Color? iconColor;
  final void Function()? onTap;
  final bool isBorderEnabled;
  final int? maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obScureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      style: isBorderEnabled
          ? AppTextStyle.poppinsMedium
              .copyWith(fontSize: 15, fontWeight: FontWeight.w300)
          : AppTextStyle.poppinsMedium
              .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        errorMaxLines: 2,
        errorStyle: AppTextStyle.poppinsSemiBold
            .copyWith(color: Colors.red, fontSize: 13),
        suffixIcon: iconWidget,
        suffixIconColor: iconColor,
        hintText: hinttext,
        hintStyle: AppTextStyle.poppinsMedium.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: isBorderEnabled
              ? Colors.black.withOpacity(0.25)
              : AppColors.darkGreyColor,
        ),
        filled: true,
        fillColor: isBorderEnabled
            ? Colors.white
            : AppColors.greyColor.withOpacity(.7),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: isBorderEnabled
              ? const BorderSide(
                  width: 1,
                  color: Colors.green,
                )
              : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: isBorderEnabled
              ? const BorderSide(
                  width: 2,
                  color: Colors.green,
                )
              : BorderSide.none,
        ),
      ),
    );
  }
}
