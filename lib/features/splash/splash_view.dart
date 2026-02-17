import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/app_image.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImage.imagesLogoLogoWhite,
              width: 40,
              height: 40,
            ),
            SvgPicture.asset(
              AppImage.imagesLogoLogoWritting,
              width: 40,
              height: 22,
            ),
          ],
        ),
      ),
    );
  }
}
