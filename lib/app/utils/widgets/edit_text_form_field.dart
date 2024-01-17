import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';

class EditTextFormField extends StatelessWidget {
  const EditTextFormField({
    Key? key,
    this.hinttext,
    this.obScureText = false,
    this.validator,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.focusNode,
    this.onTap,
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

  final void Function()? onTap;
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
      style: AppTextStyle.poppinsMedium
          .copyWith(fontSize: 15, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        errorMaxLines: 2,
        errorStyle: AppTextStyle.poppinsSemiBold
            .copyWith(color: Colors.red, fontSize: 13),
        hintText: hinttext,
        hintStyle: AppTextStyle.poppinsRegular.copyWith(fontSize: 15),
        filled: true,
        fillColor: AppColors.greyColor.withOpacity(.4),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
        enabledBorder: InputBorder.none,
      ),
    );
  }
}
