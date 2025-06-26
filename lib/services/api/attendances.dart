import 'package:dio/dio.dart';
import 'package:najati_test/config/header_config.dart';
import 'package:najati_test/core/constants/url_manager.dart';
import '../../dio_interceptor.dart';
import '../../models/attendances/send_prayer_status_response.dart';

class AttendancesService {
  final dio = DioClient.dio;

  AttendancesService();
  Future<void> postAttendances(AttendancesRequest data) async {
    try {
      final response = await dio.post(
        '${UrlManager.sendInfoChild}', // replace with your actual endpoint
        data: data.toJson(),
        options: HeaderConfig.getHeader(useToken: true), // if needed
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Attendance data submitted successfully.");
      } else {
        print("Failed to post attendances: ${response.statusCode}");
        throw Exception("Failed to post attendances");
      }
    } on DioException catch (e) {
      print("Dio error: ${e.message}");
      throw Exception("Dio error: ${e.message}");
    }
  }
}
