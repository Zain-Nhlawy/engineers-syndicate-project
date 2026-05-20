import 'package:dio/dio.dart';
import 'api.dart';
import '../storage/secure_storage.dart';
import '../storage/storage_keys.dart';

class DioClient extends Api {
  final AppSecureStorage storage;

  DioClient({required this.storage}) : super() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['User-Agent'] = 'Flutter-Mobile-App';
          options.headers['X-Platform'] = 'mobile'; 
          options.headers['isWeb'] = 'false';
          final isAuthRequest = options.path.contains('authentication');
          if (!isAuthRequest) {
            final token = await storage.read(StorageKeys.token);
            print('Request Path: ${options.path}');
            print('Token extracted from Storage: "$token"');
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
              print('Authorization Header added successfully!');
            }
            else{
              print('Warning: Token is NULL or EMPTY! Header not added.');
            }
          }
          if (options.data is FormData) {
            options.headers['Content-Type'] = 'multipart/form-data';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          return handler.next(error);
        },
      ),
    );
    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
  }
}
