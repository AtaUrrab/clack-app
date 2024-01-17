import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import '../res/app_text_style.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    Key? key,
    this.hinttext,
    this.obScureText = false,
    this.validator,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.focusNode,
  }) : super(key: key);

  final String? hinttext;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obScureText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obScureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      style: AppTextStyle.poppinsSemiBold.copyWith(fontSize: 15),
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle:
            AppTextStyle.poppinsRegular.copyWith(color: AppColors.greyColor),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.greenColor, width: 2),
        ),
      ),
    );
  }
}
