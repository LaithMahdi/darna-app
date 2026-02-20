import 'package:go_router/go_router.dart';
import '../core/helper/cacher_helper.dart';
import '../features/auth/views/forgot_password_view.dart';
import '../features/auth/views/login_view.dart';
import '../features/auth/views/register_view.dart';
import '../features/colocation/views/create_colocation_view.dart';
import '../features/complet_profile/views/complet_profile_screen.dart';
import '../features/layout/views/layout_view.dart';
import '../features/onboarding/views/onboarding_view.dart';
import '../features/splash/splash_view.dart';

abstract class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String completProfile = '/complet-profile';
  static const String createColocation = '/create-colocation';
  static const String layout = '/layout';

  static final router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashView()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingView(),
        redirect: (context, state) {
          if (CacherHelper().isOnboardingCompleted()) {
            return login;
          }
          return null;
        },
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginView(),
        redirect: (context, state) {
          if (CacherHelper().isCompletProfile()) {
            return completProfile;
          }
          return null;
        },
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: completProfile,
        builder: (context, state) => const CompletProfileScreen(),
      ),
      GoRoute(
        path: createColocation,
        builder: (context, state) => const CreateColocationView(),
      ),
      GoRoute(path: layout, builder: (context, state) => const LayoutView()),
    ],
  );
}
