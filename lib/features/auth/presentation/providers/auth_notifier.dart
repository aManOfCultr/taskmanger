import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/features/auth/presentation/providers/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(AuthState());

  void toggleAuthMode() {
    state = AuthState(isLogin: !state.isLogin, isAuthenticating: false);
  }

  void setAuthenticating(bool value) {
    state = AuthState(isLogin: state.isLogin, isAuthenticating: value);
  }

  void setError(String? message) {
    state = AuthState(
        isLogin: state.isLogin, isAuthenticating: false, errorMessage: message);
  }

  Future<void> logout() async {
    try {
      setAuthenticating(true); // Optionally show a loading state
      await FirebaseAuth.instance.signOut();
      state = AuthState(); // Reset state to default (unauthenticated)
    } catch (e) {
      setError("Failed to logout. Please try again.");
    } finally {
      setAuthenticating(false); // Reset loading state
    }
  }
}
