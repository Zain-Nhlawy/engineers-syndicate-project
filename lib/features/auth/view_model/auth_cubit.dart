import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/secure_storage.dart'; 
import '../../../../core/storage/storage_keys.dart';   
import '../data/models/user_model.dart';
import '../data/services/auth_api_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthApiService authApiService;
  final AppSecureStorage storage; 

  AuthCubit({
    required this.authApiService,
    required this.storage,
  }) : super(AuthInitial());

  Future<void> signUp(UserModel user) async {
    emit(AuthLoading());
    try {
      final message = await authApiService.signUp(user);
      emit(AuthSuccess(message));
    } catch (e) {
      emit(AuthError(_handleError(e)));
    }
  }

  Future<void> signIn(String phoneNumber, String password) async {
    if (phoneNumber.isEmpty || password.isEmpty) {
      emit(AuthError('الرجاء ملء جميع الحقول'));
      return;
    }

    emit(AuthLoading());
    try {
      final dynamic dynamicResponse = await authApiService.signIn(phoneNumber, password);
      String? token;
      String? username;
      if (dynamicResponse is Map<String, dynamic>) {
        if (dynamicResponse.containsKey('data') && dynamicResponse['data'] is Map) {
          token = dynamicResponse['data']['accessToken'];
          username = dynamicResponse['data']['user']?['firstName'];
        }
          if (token == null) {
          token = dynamicResponse['accessToken'];
          username = dynamicResponse['user']?['firstName'];
        }
      } 
      else {
        try {
          token = dynamicResponse.data?['accessToken'] ?? dynamicResponse.data?.accessToken;
          username = dynamicResponse.data?['user']?['firstName'] ?? dynamicResponse.data?.user?.firstName;
        } catch (_) {}
      }
      print('Smart Extracted Token: $token');
      if (token != null && token.isNotEmpty) {
        await storage.write(StorageKeys.token, token);
        print('Token saved successfully to storage!');
      } else {
        print('Critical Warning: Token is still null. Response type: ${dynamicResponse.runtimeType}');
      }
      if (username != null && username.isNotEmpty) {
        await storage.write(StorageKeys.username, username);
      }
      emit(AuthLoginSuccess(dynamicResponse));
    } catch (e) {
      print('Catch Error in SignIn Cubit: $e');
      emit(AuthError(_handleError(e)));
    }
  }

  Future<void> logout() async {
    await storage.delete(StorageKeys.token);
    await storage.delete(StorageKeys.username);
    emit(AuthInitial());
  }

  String _handleError(dynamic e) {
    final msg = e.toString();
    if (msg.contains('401')) {
      return 'رقم الهاتف أو كلمة المرور غير صحيحة';
    } else if (msg.contains('500')) {
      return 'خطأ في السيرفر الداخلي';
    } else if (msg.contains('SocketException')) {
      return 'لا يوجد اتصال بالإنترنت، تحقق من الشبكة';
    }
    return msg;
  }

  Future<void> forgotPassword(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      emit(ForgotPasswordError('الرجاء إدخال رقم الهاتف'));
      return;
    }

    emit(ForgotPasswordLoading());
    try {
      final response = await authApiService.forgotPassword(phoneNumber);
      
      final String message = response['message'] ?? 'تم إرسال رمز التحقق بنجاح';
      emit(ForgotPasswordEmailSentSuccess(message));
    } catch (e) {
      emit(ForgotPasswordError(_handleError(e)));
    }
  }

  Future<void> resetPassword({
    required String phoneNumber,
    required String token,
    required String newPassword,
  }) async {
    if (token.isEmpty || newPassword.isEmpty) {
      emit(ResetPasswordError('الرجاء ملء جميع الحقول'));
      return;
    }

    emit(ResetPasswordLoading());
    try {
      final response = await authApiService.resetPassword(
        phoneNumber: phoneNumber,
        token: token,
        newPassword: newPassword,
      );
      emit(ResetPasswordSuccess(response['message'] ?? 'تم تغيير كلمة المرور بنجاح'));
    } catch (e) {
      emit(ResetPasswordError(e.toString().replaceAll('Exception: ', '')));
    }
  }

}