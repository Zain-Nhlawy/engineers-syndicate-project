import 'package:dio/dio.dart';
import 'package:engineers_syndicate_project/core/network/dio_client.dart';
import 'package:engineers_syndicate_project/features/events/data/model/event_model.dart';
import 'package:get_it/get_it.dart';

class EventsServices {
final DioClient _dioClient = GetIt.instance<DioClient>();
  Future<List<EventModel>> getEvents() async {
    try {
      final response = await _dioClient.dio.get('events');
      final data = response.data;
      
      if (response.statusCode == 200 && data['data'] != null) {
        final List<dynamic> dataList = data['data'];
        return dataList
            .map((json) => EventModel.fromJson(json))
            .toList();
      }
      throw Exception(data['message'] ?? 'فشل في جلب الفعاليات');
    } on DioException catch (e) {
      throw Exception(_dioClient.handleError(e));
    }
  }
}