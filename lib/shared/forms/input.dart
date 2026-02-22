import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/app_style.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.maxLines,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.onChanged,
  });

  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final int? maxLines;
  final bool? obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppStyle.styleSemiBold14,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      maxLines: maxLines ?? 1,
      obscureText: obscureText ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: AppColor.black,
      onChanged: onChanged,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      readOnly: readOnly,
      decoration: InputDecoration(
        errorStyle: AppStyle.styleSemiBold12.copyWith(color: AppColor.error),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        hintText: hintText,
        hintStyle: AppStyle.styleMedium13.copyWith(color: AppColor.grey9A),
        filled: true,
        fillColor: AppColor.whiteFA,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: AppColor.grey9A),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: AppColor.grey9A),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: AppColor.grey9A),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: AppColor.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: AppColor.error),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
