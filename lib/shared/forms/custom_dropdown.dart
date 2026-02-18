import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/app_style.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    super.key,
    this.items,
    this.onChanged,
    this.initialValue,
    this.prefixIcon,
    this.hintText = "Select ...",
  });

  final List<DropdownMenuItem<T>>? items;
  final void Function(T? value)? onChanged;
  final T? initialValue;
  final String hintText;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      items: items,
      onChanged: onChanged,
      initialValue: initialValue,
      hint: Text(
        hintText,
        style: AppStyle.styleMedium13.copyWith(color: AppColor.grey9A),
      ),
      icon: Icon(LucideIcons.chevronDown, color: AppColor.grey9A, size: 20),
      style: AppStyle.styleSemiBold14.copyWith(color: AppColor.black),
      borderRadius: BorderRadius.circular(7),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
        errorStyle: AppStyle.styleSemiBold12.copyWith(color: AppColor.error),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
