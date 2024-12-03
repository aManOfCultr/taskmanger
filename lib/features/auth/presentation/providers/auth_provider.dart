import 'package:riverpod/riverpod.dart';
import 'package:taskmanager/features/auth/presentation/providers/auth_notifier.dart';
import 'package:taskmanager/features/auth/presentation/providers/auth_state.dart';

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier();
});
