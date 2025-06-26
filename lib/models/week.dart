import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:najati_test/config/header_config.dart';

import '../core/constants/url_manager.dart';
import '../dio_interceptor.dart';

final service = WeeklyStatsService();

void getStats(int id, int currentWeek) async {
  try {
    final stats = await service.fetchWeeklyStats(id, currentWeek);
    print('Week starts on: ${stats.data.weekStart}');
  } catch (e) {
    print(e);
  }
}

class WeeklyStatsService {
  final dio = DioClient.dio;

  WeeklyStatsService();
  Future<WeeklyStatsResponse> fetchWeeklyStats(int id, int currentWeek) async {
    try {
      String getWeek =
          '${UrlManager.baseUrl}/api/children/$id/prayer-statistics/week?week=$currentWeek';
      log(
        '${UrlManager.baseUrl}/api/children/$id/prayer-statistics/week?week=$currentWeek',
      );
      log("++++++++++++++++");
      final response = await dio.get(
        getWeek,
        options: HeaderConfig.getHeader(useToken: true),
      );

      if (response.statusCode == 200) {
        return WeeklyStatsResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to load weekly stats, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching weekly stats: $e');
    }
  }
}

class WeeklyStatsResponse {
  final String status;
  final String message;
  final WeeklyStatsData data;

  WeeklyStatsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory WeeklyStatsResponse.fromJson(Map<String, dynamic> json) {
    return WeeklyStatsResponse(
      status: json['status'],
      message: json['message'],
      data: WeeklyStatsData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.toJson(),
  };
}

class WeeklyStatsData {
  final String weekStart;
  final String weekEnd;
  final List<DayStats> days;

  WeeklyStatsData({
    required this.weekStart,
    required this.weekEnd,
    required this.days,
  });

  factory WeeklyStatsData.fromJson(Map<String, dynamic> json) {
    return WeeklyStatsData(
      weekStart: json['week_start'],
      weekEnd: json['week_end'],
      days:
          (json['days'] as List).map((day) => DayStats.fromJson(day)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'week_start': weekStart,
    'week_end': weekEnd,
    'days': days.map((day) => day.toJson()).toList(),
  };
}

class DayStats {
  final String date;
  final List<PrayerStatus> prayers;

  DayStats({required this.date, required this.prayers});

  factory DayStats.fromJson(Map<String, dynamic> json) {
    return DayStats(
      date: json['date'],
      prayers:
          (json['prayers'] as List)
              .map((p) => PrayerStatus.fromJson(p))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'date': date,
    'prayers': prayers.map((p) => p.toJson()).toList(),
  };
}

class PrayerStatus {
  final int prayerId;
  final int? status;

  PrayerStatus({required this.prayerId, required this.status});

  factory PrayerStatus.fromJson(Map<String, dynamic> json) {
    return PrayerStatus(prayerId: json['prayer_id'], status: json['status']);
  }

  Map<String, dynamic> toJson() => {'prayer_id': prayerId, 'status': status};
}
