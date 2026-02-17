import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_image.dart';

class SplashAnimatedBuilder extends StatelessWidget {
  const SplashAnimatedBuilder({
    super.key,
    required Animation<Offset> slidingAnimation,
  }) : _slidingAnimation = slidingAnimation;

  final Animation<Offset> _slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slidingAnimation,
      builder: (context, _) => SlideTransition(
        position: _slidingAnimation,
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
