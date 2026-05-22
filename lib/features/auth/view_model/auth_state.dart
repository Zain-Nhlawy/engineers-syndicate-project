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

class AuthOtpLoading extends AuthState {}
class AuthOtpSuccess extends AuthState {
  final String message;
  AuthOtpSuccess(this.message);
}
class AuthOtpError extends AuthState {
  final String error;
  AuthOtpError(this.error);
}

class AuthResendOtpLoading extends AuthState {}
class AuthResendOtpSuccess extends AuthState {
  final String message;
  AuthResendOtpSuccess(this.message);
}
class AuthResendOtpError extends AuthState {
  final String error;
  AuthResendOtpError(this.error);
}

class ForgotPasswordLoading extends AuthState {}
class ForgotPasswordEmailSentSuccess extends AuthState {
  final String message;
  ForgotPasswordEmailSentSuccess(this.message);
}
class ForgotPasswordError extends AuthState {
  final String error;
  ForgotPasswordError(this.error);
}

class ResetPasswordLoading extends AuthState {}
class ResetPasswordSuccess extends AuthState {
  final String message;
  ResetPasswordSuccess(this.message);
}
class ResetPasswordError extends AuthState {
  final String error;
  ResetPasswordError(this.error);
}


