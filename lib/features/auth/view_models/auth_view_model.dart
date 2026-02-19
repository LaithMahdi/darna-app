import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state.dart';
import '../models/user_model.dart';
import '../service/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((
  ref,
) {
  final authService = ref.watch(authServiceProvider);
  return AuthViewModel(authService);
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthViewModel(this._authService) : super(AuthState.initial()) {
    _checkAuthStatus();
  }

  // Check initial auth status
  Future<void> _checkAuthStatus() async {
    final user = _authService.currentUser;
    if (user != null) {
      state = AuthState.authenticated(
        UserModel(
          uid: user.uid,
          email: user.email!,
          fullName: user.displayName,
        ),
      );
    } else {
      state = AuthState.unauthenticated();
    }
  }

  // Sign in with email and password
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = AuthState.loading();

    final result = await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.fold(
      (error) {
        state = AuthState.error(error);
        return false;
      },
      (firebaseUser) {
        if (firebaseUser != null) {
          state = AuthState.authenticated(
            UserModel(
              uid: firebaseUser.uid,
              email: firebaseUser.email!,
              fullName: firebaseUser.displayName,
            ),
          );
          return true;
        } else {
          state = AuthState.error('User authentication failed');
          return false;
        }
      },
    );
  }

  // Register with email and password
  Future<bool> registerWithEmailAndPassword({
    required UserModel user,
    required String password,
  }) async {
    state = AuthState.loading();

    final result = await _authService.registerWithEmailAndPassword(
      user,
      password,
    );

    return result.fold(
      (error) {
        state = AuthState.error(error);
        return false;
      },
      (newUser) {
        state = AuthState.authenticated(newUser);
        return true;
      },
    );
  }

  // Sign in with Google
  Future<bool> signInWithGoogle() async {
    final result = await _authService.signInWithGoogle();
    return result.fold(
      (error) {
        state = AuthState.error(error);
        return false;
      },
      (firebaseUser) {
        if (firebaseUser != null) {
          state = AuthState.authenticated(
            UserModel(
              uid: firebaseUser.uid,
              email: firebaseUser.email!,
              fullName: firebaseUser.displayName,
            ),
          );
          return true;
        } else {
          state = AuthState.error('Google sign-in failed');
          return false;
        }
      },
    );
  }
}
