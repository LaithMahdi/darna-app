import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_color.dart';
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
    navigateToOnboarding();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _slidingAnimation = Tween<Offset>(begin: Offset(-4, 0), end: Offset.zero)
        .chain(CurveTween(curve: FlippedCurve(Curves.easeInOut)))
        .animate(_animationController);
    _animationController.forward();
  }

  void navigateToOnboarding() {
    Future.delayed(Duration(seconds: 2), () {
      GoRouter.of(context).push(Routes.onboarding);
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
