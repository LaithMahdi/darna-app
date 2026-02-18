import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/app_style.dart';

class RoleSelector extends StatelessWidget {
  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
  });

  final String selectedRole;
  final Function(String role) onRoleSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.greyF0,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: ["Owner", "Visitor"].map((e) {
          final isSelected = e == selectedRole;
          return Expanded(
            child: InkWell(
              onTap: () => onRoleSelected(e),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColor.primary.withValues(alpha: .2)
                      : null,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: isSelected ? AppColor.primary : Colors.transparent,
                  ),
                ),
                child: Text(
                  e,
                  style: AppStyle.styleSemiBold14.copyWith(
                    color: isSelected ? AppColor.primary : AppColor.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
