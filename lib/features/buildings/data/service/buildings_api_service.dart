
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/building_model.dart';

class BuildingsApiService {
  final DioClient dioClient;

  BuildingsApiService({required this.dioClient});

  Future<List<BuildingModel>> getBuildings() async {
    try {
      final response = await dioClient.dio.get('buildings'); 

      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data['data'] ?? [];
        return dataList.map((json) => BuildingModel.fromJson(json)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'فشل في جلب الأبنية');
      }
    } on DioException catch (e) {
      throw Exception(dioClient.handleError(e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}