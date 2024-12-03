class AuthState {
  final bool isLogin;
  final bool isAuthenticating;
  final String? errorMessage;

  AuthState({this.isLogin = true, this.isAuthenticating = false, this.errorMessage});
}