import 'package:dio/dio.dart';
import '../../models/attendances/send_prayer_status_response.dart';

class AttendancesService {
  final Dio _dio;

  AttendancesService(this._dio);

  Future<SendPrayerStatusResponse> sendPrayerStatus({
    required List<Map<String, dynamic>> attendances,
  }) async {
    final response = await _dio.post(
      '/api/attendances',
      data: {'attendances': attendances},
    );

    return SendPrayerStatusResponse.fromJson(response.data);
  }
}
