import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constants/app_color.dart';
import '../core/constants/app_image.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        Image.asset(AppImage.imagesLogoLogo, width: 60, height: 60),
        SvgPicture.asset(
          AppImage.imagesLogoLogoWritting,
          width: 200,
          height: 22,
          colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
        ),
      ],
    );
  }
}
