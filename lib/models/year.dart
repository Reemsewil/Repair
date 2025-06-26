import 'package:dio/dio.dart';

import '../config/header_config.dart';
import '../core/constants/url_manager.dart';
import '../dio_interceptor.dart';
import '../statistics/view/statistics.dart';

final service = YearlyStatsService();

void loadYearlyStats(int childId, int currentYear) async {
  try {
    final stats = await service.fetchYearlyStats(childId, currentYear);
    print('First count: ${stats.data.first.count}');
  } catch (e) {
    print(e);
  }
}

class YearlyStatsService {
  final dio = DioClient.dio;

  YearlyStatsService();

  Future<YearlyStatsResponse> fetchYearlyStats(
    int childId,
    int currentYear,
  ) async {
    try {
      String getYear =
          '${UrlManager.baseUrl}/api/children/$childId/prayer-statistics/annual?year=$currentYear';

      final response = await dio.get(
        getYear,
        options: HeaderConfig.getHeader(useToken: true),
      );

      if (response.statusCode == 200) {
        return YearlyStatsResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to load yearly stats, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching yearly stats: $e');
    }
  }
}

class YearlyStatsResponse {
  final String status;
  final String message;
  final List<YearlyStatItem> data;

  YearlyStatsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory YearlyStatsResponse.fromJson(Map<String, dynamic> json) {
    return YearlyStatsResponse(
      status: json['status'],
      message: json['message'],
      data:
          (json['data'] as List)
              .map((e) => YearlyStatItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class YearlyStatItem {
  final int count;

  YearlyStatItem({required this.count});

  factory YearlyStatItem.fromJson(Map<String, dynamic> json) {
    return YearlyStatItem(count: json['count']);
  }

  Map<String, dynamic> toJson() => {'count': count};
}
