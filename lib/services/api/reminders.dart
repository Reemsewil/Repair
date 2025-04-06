import 'package:dio/dio.dart';
import '../../models/reminder/create_reminder_response.dart';
import '../../models/reminder/get_reminder_response.dart';

class RemindersService {
  final Dio _dio;

  RemindersService(this._dio);

  Future<CreateReminderResponse> createReminder({
    required int prayerId,
    required int childId,
    required int minutes,
  }) async {
    final formData = FormData.fromMap({
      'prayer_id': prayerId,
      'child_id': childId,
      'minutes': minutes,
    });

    final response = await _dio.post('/reminders', data: formData);

    return CreateReminderResponse.fromJson(response.data);
  }

  Future<GetReminderResponse> getReminders({required int childId}) async {
    final response = await _dio.get('/api/child/$childId/reminders');

    return GetReminderResponse.fromJson(response.data);
  }
}
