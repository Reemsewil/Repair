import 'dart:developer';

import 'package:dio/dio.dart';

import '../config/header_config.dart';
import '../core/constants/url_manager.dart';
import '../dio_interceptor.dart';

class PrayerStatsService {
  final dio = DioClient.dio;

  PrayerStatsService();

  Future<MonthlyStatsResponse> getMonthlyStats({
    required int id,
    required int currentMonth, // e.g., "2025-06"
  }) async {
    DateTime now = DateTime.now();
    String formattedMonth =
        '${now.year}-${currentMonth.toString().padLeft(2, '0')}';

    try {
      String getMonth =
          '${UrlManager.baseUrl}/api/children/$id/prayer-statistics/month?month=$currentMonth';
      log(getMonth);
      log("$currentMonth");
      final response = await dio.get(
        getMonth,
        options: HeaderConfig.getHeader(useToken: true),
      );

      if (response.statusCode == 200) {
        log("msjhan ahhh");
        return MonthlyStatsResponse.fromJson(response.data);
      } else {
        log("msjhan ah=========hh");

        throw Exception('Failed to load monthly stats');
      }
    } on DioException catch (e) {
      log("msjhan ahhjjjjjjjh");
      log(e.message!);

      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}

final service = PrayerStatsService();

void fetchStats(int childId, int currentMonth) async {
  try {
    final stats = await service.getMonthlyStats(
      id: childId,
      currentMonth: currentMonth,
    );
    print(stats.data.days.length); // مثلاً عدد الأيام
  } catch (e) {
    print('Error: $e');
  }
}

class PrayerStatus {
  final int prayerId;
  final int? status; // can be null

  PrayerStatus({required this.prayerId, this.status});

  factory PrayerStatus.fromJson(Map<String, dynamic> json) {
    return PrayerStatus(prayerId: json['prayer_id'], status: json['status']);
  }

  Map<String, dynamic> toJson() => {'prayer_id': prayerId, 'status': status};
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
              .map((e) => PrayerStatus.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'date': date,
    'prayers': prayers.map((e) => e.toJson()).toList(),
  };
}

class MonthlyStatsData {
  final String month;
  final List<DayStats> days;

  MonthlyStatsData({required this.month, required this.days});

  factory MonthlyStatsData.fromJson(Map<String, dynamic> json) {
    return MonthlyStatsData(
      month: json['month'],
      days: (json['days'] as List).map((e) => DayStats.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'month': month,
    'days': days.map((e) => e.toJson()).toList(),
  };
}

class MonthlyStatsResponse {
  final String status;
  final String message;
  final MonthlyStatsData data;

  MonthlyStatsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MonthlyStatsResponse.fromJson(Map<String, dynamic> json) {
    return MonthlyStatsResponse(
      status: json['status'],
      message: json['message'],
      data: MonthlyStatsData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.toJson(),
  };
}
