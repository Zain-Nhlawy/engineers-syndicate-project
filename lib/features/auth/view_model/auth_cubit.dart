import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/user_model.dart';
import '../data/services/auth_api_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthApiService authApiService;

  AuthCubit({
    required this.authApiService,
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
      final userData = await authApiService.signIn(phoneNumber, password);
      emit(AuthLoginSuccess(userData));
    } catch (e) {
      emit(AuthError(_handleError(e)));
    }
  }

  String _handleError(dynamic e) {
    final msg = e.toString();

    if (msg.contains('401')) {
      return 'غير مصرح، تحقق من البيانات';
    } else if (msg.contains('500')) {
      return 'خطأ في السيرفر';
    } else if (msg.contains('SocketException')) {
      return 'لا يوجد اتصال بالإنترنت';
    }

    return msg;
  }
}