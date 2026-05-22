import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';
import 'dart:convert'; 

class AuthApiService {
  final DioClient dioClient;

  AuthApiService({required this.dioClient});

  Future<String> signUp(UserModel user) async {
    try {
        final response = await dioClient.dio.post(
        'authentication/sign-up',
        data: jsonEncode(user.toJson()), 
      );

      final data = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        return data['message'];
      } else {
        throw Exception(data['message'] ?? 'Signup failed');
      }
    } on DioException catch (e) {
      throw Exception(dioClient.handleError(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<Map<String, dynamic>> signIn(String phoneNumber, String password) async {
    try {
      final response = await dioClient.dio.post(
        'authentication/sign-in',
        data: jsonEncode({
          "phoneNumber": phoneNumber,
          "password": password,
        }),
      );

      final data = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['success'] == true) {
          return data['data'] ?? {};
        } else {
          throw Exception(data['message'] ?? 'Login failed');
        }
      } else {
        throw Exception(data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      throw Exception(dioClient.handleError(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String phoneNumber) async {
    try {
      final response = await dioClient.dio.post(
        'authentication/forgot-password', 
        data: jsonEncode({
          "phoneNumber": phoneNumber,
        }),
      );
      final data = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data is Map<String, dynamic>) {
          return data;
        } else {
          return {};
        }
      } else {
        throw Exception(data['message'] ?? 'Forgot password request failed');
      }
    } on DioException catch (e) {
      throw Exception(dioClient.handleError(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    required String phoneNumber,
    required String token,
    required String newPassword,
  }) async {
    try {
      final response = await dioClient.dio.post(
        'authentication/reset-password', 
        data: jsonEncode({
          "phoneNumber": phoneNumber,
          "token": token,
          "password": newPassword,
        }),
      );
      final data = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data is Map<String, dynamic>) {
          return data;
        } else {
          return {};
        }
      } else {
        throw Exception(data['message'] ?? 'فشلت عملية إعادة التعيين');
      }
    } on DioException catch (e) {
      throw Exception(dioClient.handleError(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}