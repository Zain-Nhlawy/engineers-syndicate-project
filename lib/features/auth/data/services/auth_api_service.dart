import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/storage_keys.dart';
import '../models/user_model.dart';

class AuthApiService {
  final DioClient _dioClient = GetIt.instance<DioClient>();
  late final Dio refreshDio;

  AuthApiService() {
    refreshDio = Dio(
      BaseOptions(
        baseUrl: _dioClient.dio.options.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  Future<Map<String, dynamic>> signIn(String phoneNumber, String password) async {
    try {
      final response = await _dioClient.dio.post(
        'authentication/sign-in',
        data: {"phoneNumber": phoneNumber, "password": password},
        options: Options(extra: {'noAuth': true}),
      );
      final data = response.data;
      if (response.statusCode == 200 && data['success'] == true) {
        final tokens = data['data'];
        await _saveTokens(
          accessToken: tokens['accessToken'],
          refreshToken: tokens['refreshToken'],
        );
        return tokens;
      }
      throw Exception(data['message'] ?? 'Login failed');
    } on DioException catch (e) {
      throw Exception(_dioClient.handleError(e));
    }
  }

  Future<String?> refreshToken() async {
    try {
      final storedRefreshToken = await _dioClient.storage.read(StorageKeys.refreshToken);
      if (storedRefreshToken == null) return null;
      final response = await refreshDio.post(
        'authentication/refresh-tokens',
        data: {"refreshToken": storedRefreshToken},
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        final newAccessToken = response.data['data']['accessToken'];
        final newRefreshToken = response.data['data']['refreshToken'];
        await _saveTokens(accessToken: newAccessToken, refreshToken: newRefreshToken);
        return newAccessToken;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> shouldRefreshToken() async {
    final token = await _dioClient.storage.read(StorageKeys.token);
    if (token == null) return true;
    try {
      final expirationDate = JwtDecoder.getExpirationDate(token);
      return expirationDate.difference(DateTime.now()).inSeconds <= 20;
    } catch (e) {
      return true;
    }
  }

  Future<void> refreshIfNeeded() async {
    if (await shouldRefreshToken()) await refreshToken();
  }

  Future<void> _saveTokens({required String accessToken, required String refreshToken}) async {
    await _dioClient.storage.write(StorageKeys.token, accessToken);
    await _dioClient.storage.write(StorageKeys.refreshToken, refreshToken);
  }

  Future<void> logout() async {
    await _dioClient.storage.delete(StorageKeys.token);
    await _dioClient.storage.delete(StorageKeys.refreshToken);
  }

  Future<String> signUp(UserModel user) async {
    try {
      final response = await _dioClient.dio.post(
        'authentication/sign-up',
        data: user.toJson(),
        options: Options(extra: {'noAuth': true}),
      );
      return response.data['message']?.toString() ?? 'Success';
    } on DioException catch (e) {
      throw Exception(_dioClient.handleError(e));
    }
  }

  Future<Map<String, dynamic>> verifyOtp({required String phoneNumber, required String secret}) async {
    try {
      final response = await _dioClient.dio.post(
        'authentication/verify-otp',
        data: {"phoneNumber": phoneNumber, "secret": secret},
        options: Options(extra: {'noAuth': true}),
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data;
      } else {
        throw Exception(response.data['message'] ?? 'رمز التحقق غير صحيح');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        final retryAfter = e.response?.headers.value('retry-after') ?? '900';
        throw Exception('429:$retryAfter');
      }
      throw Exception(_dioClient.handleError(e));
    }
  }

  Future<Map<String, dynamic>> resendOtp(String phoneNumber) async {
    try {
      final response = await _dioClient.dio.post(
        'authentication/resend-otp',
        data: {"phoneNumber": phoneNumber},
        options: Options(extra: {'noAuth': true}),
      );
      return response.data['data'] ?? {};
    } on DioException catch (e) {
      throw Exception(_dioClient.handleError(e));
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String phoneNumber) async {
    try {
      final response = await _dioClient.dio.post(
        'authentication/forgot-password',
        data: {"phoneNumber": phoneNumber},
        options: Options(extra: {'noAuth': true}),
      );
      return response.data['data'] ?? {};
    } on DioException catch (e) {
      throw Exception(_dioClient.handleError(e));
    }
  }

  Future<Map<String, dynamic>> resetPassword({required String phoneNumber, required String token, required String newPassword}) async {
    try {
      final response = await _dioClient.dio.post(
        'authentication/reset-password',
        data: {"phoneNumber": phoneNumber, "token": token, "password": newPassword},
        options: Options(extra: {'noAuth': true}),
      );
      return response.data['data'] ?? {};
    } on DioException catch (e) {
      throw Exception(_dioClient.handleError(e));
    }
  }
}