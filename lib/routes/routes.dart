import 'package:go_router/go_router.dart';
import '../features/onboarding/views/onboarding_view.dart';
import '../features/splash/splash_view.dart';

abstract class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';

  static final router = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashView()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingView(),
      ),
    ],
  );
}
