import 'package:go_router/go_router.dart';
import '../features/splash/splash_view.dart';

abstract class Routes {
  static const String splash = '/';

  static final router = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashView()),
    ],
  );
}
