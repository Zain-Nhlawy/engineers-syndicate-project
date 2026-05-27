import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/network/dio_client.dart';
import '../models/building_model.dart';

class BuildingsApiService {
  final DioClient _dioClient = GetIt.instance<DioClient>();

  BuildingsApiService();

  Future<List<BuildingModel>> getBuildings() async {
    try {
      final response = await _dioClient.dio.get('buildings/cursor');
      final data = response.data;

      if (response.statusCode == 200 && data['data'] != null) {
        final List<dynamic> dataList = data['data'];
        return dataList
            .map((json) => BuildingModel.fromJson(json))
            .toList();
      }
      throw Exception(data['message'] ?? 'فشل في جلب الأبنية');
    } on DioException catch (e) {
      throw Exception(_dioClient.handleError(e));
    }
  }

  Future<BuildingModel> getBuildingById(int id) async {
    try {
      final response = await _dioClient.dio.get('buildings/$id');
      final data = response.data;

      if (response.statusCode == 200 && data['data'] != null) {
        return BuildingModel.fromJson(data['data']);
      }
      throw Exception(data['message'] ?? 'فشل في جلب بيانات المبنى');
    } on DioException catch (e) {
      throw Exception(_dioClient.handleError(e));
    }
  }
}