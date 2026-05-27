import 'package:engineers_syndicate_project/core/network/dio_client.dart';
import 'package:engineers_syndicate_project/features/halls/data/model/halls_model.dart';
import 'package:get_it/get_it.dart';

class HallsServices {
  final DioClient _dioClient = GetIt.instance<DioClient>();

  Future<List<HallsModel>> getHalls() async {
    try {
      final response = await _dioClient.dio.get('rooms');
      final data = response.data;

      if (response.statusCode == 200 && data['data'] != null) {
        final List<dynamic> dataList = data['data'];
        return dataList.map((json) => HallsModel.fromJson(json)).toList();
      }
      throw Exception(data['message'] ?? 'فشل في جلب القاعات');
    } catch (e) {
      throw Exception('حدث خطأ أثناء جلب القاعات: $e');
    }
  }
}
