import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_color.dart';
import '../../core/helper/cacher_helper.dart';
import '../../routes/routes.dart';
import 'widgets/splash_animated_builder.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slidingAnimation;

  @override
  void initState() {
    super.initState();
    initAnimation();
    navigateToNextScreen();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _slidingAnimation =
        Tween<Offset>(begin: const Offset(-4, 0), end: Offset.zero)
            .chain(CurveTween(curve: FlippedCurve(Curves.easeInOut)))
            .animate(_animationController);
    _animationController.forward();
  }

  void navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      final cacheHelper = CacherHelper();
      final isOnboardingCompleted = cacheHelper.isOnboardingCompleted();

      if (mounted) {
        if (isOnboardingCompleted) {
          context.go(Routes.login);
        } else {
          context.go(Routes.onboarding);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: SplashAnimatedBuilder(slidingAnimation: _slidingAnimation),
      ),
    );
  }
}
