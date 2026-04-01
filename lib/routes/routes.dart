import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/helper/cacher_helper.dart';
import '../features/auth/views/forgot_password_view.dart';
import '../features/auth/views/login_view.dart';
import '../features/auth/views/register_view.dart';
import '../features/chat/views/chat_room_view.dart';
import '../features/chat/views/chat_view.dart';
import '../features/colocation/models/colocation_model.dart';
import '../features/colocation/views/colocation_detail_view.dart';
import '../features/colocation/views/colocation_view.dart';
import '../features/colocation/views/create_colocation_view.dart';
import '../features/complet_profile/views/complet_profile_view.dart';
import '../features/layout/views/home_view.dart';
import '../features/layout/views/layout_view.dart';
import '../features/layout/views/manage_account_view.dart';
import '../features/layout/views/password_view.dart';
import '../features/layout/views/settings_view.dart';
import '../features/notifications/views/notification_view.dart';
import '../features/onboarding/views/onboarding_view.dart';
import '../features/privacyAndTermsCondition/views/help_and_support_view.dart';
import '../features/privacyAndTermsCondition/views/privacy_view.dart';
import '../features/splash/splash_view.dart';
import '../features/tasks/models/task_model.dart';
import '../features/tasks/views/task_create_view.dart';
import '../features/tasks/views/task_detail_view.dart';
import '../features/tasks/views/task_view.dart';

abstract class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String completProfile = '/complet-profile';
  static const String createColocation = '/create-colocation';
  static const String colocation = '/colocation';
  static const String colocationDetail = '/colocation-detail';
  static const String layout = '/layout';
  static const String settings = '/settings';
  static const String manageAccount = '/manage-account';
  static const String password = '/password';
  static const String home = '/home';
  static const String privacy = '/privacy';
  static const String helpAndSupport = '/help-support';
  static const String task = '/task';
  static const String taskCreate = '/task-create';
  static const String taskDetail = '/task-detail';
  static const String chat = '/chat';
  static const String chatRoom = '/chat-room';
  static const String notifications = '/notifications';

  static final router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const SplashView(),
        ),
      ),
      GoRoute(
        path: onboarding,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const OnboardingView(),
        ),
        redirect: (context, state) {
          if (CacherHelper().isOnboardingCompleted()) {
            return login;
          }
          return null;
        },
      ),
      GoRoute(
        path: login,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const LoginView(),
        ),
        redirect: (context, state) {
          if (CacherHelper().isCompletProfile()) {
            return layout;
          }
          return null;
        },
      ),
      GoRoute(
        path: register,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const RegisterView(),
        ),
      ),
      GoRoute(
        path: forgotPassword,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const ForgotPasswordView(),
        ),
      ),
      GoRoute(
        path: completProfile,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const CompletProfileView(),
        ),
      ),
      GoRoute(
        path: createColocation,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const CreateColocationView(),
        ),
      ),
      GoRoute(
        path: colocation,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const ColocationView(),
        ),
      ),
      GoRoute(
        path: colocationDetail,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: ColocationDetailView(
            colocation: state.extra is ColocationModel
                ? state.extra! as ColocationModel
                : null,
          ),
        ),
      ),
      GoRoute(
        path: layout,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const LayoutView(),
        ),
      ),
      GoRoute(
        path: settings,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const SettingsView(),
        ),
      ),
      GoRoute(
        path: manageAccount,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const ManageAccountView(),
        ),
      ),
      GoRoute(
        path: password,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const PasswordView(),
        ),
      ),
      GoRoute(
        path: home,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: privacy,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const PrivacyView(),
        ),
      ),
      GoRoute(
        path: helpAndSupport,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const HelpAndSupportView(),
        ),
      ),
      GoRoute(
        path: task,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const TaskView(),
        ),
      ),
      GoRoute(
        path: taskCreate,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const TaskCreateView(),
        ),
      ),
      GoRoute(
        path: taskDetail,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: TaskDetailView(
            task: state.extra is TaskModel ? state.extra! as TaskModel : null,
          ),
        ),
      ),
      GoRoute(
        path: chat,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const ChatView(),
        ),
      ),
      GoRoute(
        path: chatRoom,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const ChatRoomView(),
        ),
      ),
      GoRoute(
        path: notifications,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const NotificationView(),
        ),
      ),
    ],
  );

  static Page<dynamic> _buildPageWithTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);
        var fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn,
        );

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(opacity: fadeAnimation, child: child),
        );
      },
    );
  }
}
