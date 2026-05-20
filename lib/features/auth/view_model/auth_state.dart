abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess(this.message);
}

class AuthLoginSuccess extends AuthState {
  final Map<String, dynamic> userData;
  AuthLoginSuccess(this.userData);
}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}


