import 'package:engineers_syndicate_project/features/buildings/data/service/buildings_api_service.dart';
import 'package:engineers_syndicate_project/features/buildings/view_model/buildings_cubit.dart';
import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../storage/secure_storage.dart';

import '../../features/auth/data/services/auth_api_service.dart';
import '../../features/auth/view_model/auth_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<AppSecureStorage>(
    () => AppSecureStorage(),
  );

  getIt.registerLazySingleton<DioClient>(
    () => DioClient(
      storage: getIt<AppSecureStorage>(),
    ),
  );

  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiService(
      dioClient: getIt<DioClient>(),
    ),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      authApiService: getIt<AuthApiService>(),
      storage: getIt<AppSecureStorage>(), 
    ),
  );

  getIt.registerLazySingleton<BuildingsApiService>(
    () => BuildingsApiService(
      dioClient: getIt<DioClient>(),
    ),
  );

  getIt.registerFactory<BuildingsCubit>(
    () => BuildingsCubit(
      buildingsApiService: getIt<BuildingsApiService>(),
    ),
  );

}