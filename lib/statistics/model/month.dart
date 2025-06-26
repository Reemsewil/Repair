// import 'package:dio/dio.dart';

// import '../../../../config/header_config.dart';

// class PrayerStatsService {
//   final Dio _dio;

//   PrayerStatsService({Dio? dio}) : _dio = dio ?? Dio();

//   Future<MonthlyStatsResponse> getMonthlyStats({
//     required int childId,
//     required String month, // e.g., "2025-06"
//   }) async {
//     try {
//       final response = await _dio.get(
//         'https://najati.webmyidea.com/api/children/$childId/prayer-statistics/month?month=$month',
//         queryParameters: {'month': '2025-06'},
//         options: HeaderConfig.getHeader(),
//       );
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         return MonthlyStatsResponse.fromJson(response.data);
//       } else {
//         throw Exception('Failed to load monthly stats');
//       }
//     } on DioException catch (e) {
//       throw Exception('Dio error: ${e.message}');
//     } catch (e) {
//       throw Exception('Unexpected error: $e');
//     }
//   }
// }

// final service = PrayerStatsService();

// void fetchStats() async {
//   try {
//     final stats = await service.getMonthlyStats(childId: 1, month: '2025-06');
//     print(stats.data.days.length); // مثلاً عدد الأيام
//   } catch (e) {
//     print('Error: $e');
//   }
// }

// class PrayerStatus {
//   final int prayerId;
//   final int? status; // can be null

//   PrayerStatus({required this.prayerId, this.status});

//   factory PrayerStatus.fromJson(Map<String, dynamic> json) {
//     return PrayerStatus(prayerId: json['prayer_id'], status: json['status']);
//   }

//   Map<String, dynamic> toJson() => {'prayer_id': prayerId, 'status': status};
// }

// class DayStats {
//   final String date;
//   final List<PrayerStatus> prayers;

//   DayStats({required this.date, required this.prayers});

//   factory DayStats.fromJson(Map<String, dynamic> json) {
//     return DayStats(
//       date: json['date'],
//       prayers:
//           (json['prayers'] as List)
//               .map((e) => PrayerStatus.fromJson(e))
//               .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'date': date,
//     'prayers': prayers.map((e) => e.toJson()).toList(),
//   };
// }

// class MonthlyStatsData {
//   final String month;
//   final List<DayStats> days;

//   MonthlyStatsData({required this.month, required this.days});

//   factory MonthlyStatsData.fromJson(Map<String, dynamic> json) {
//     return MonthlyStatsData(
//       month: json['month'],
//       days: (json['days'] as List).map((e) => DayStats.fromJson(e)).toList(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'month': month,
//     'days': days.map((e) => e.toJson()).toList(),
//   };
// }

// class MonthlyStatsResponse {
//   final String status;
//   final String message;
//   final MonthlyStatsData data;

//   MonthlyStatsResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory MonthlyStatsResponse.fromJson(Map<String, dynamic> json) {
//     return MonthlyStatsResponse(
//       status: json['status'],
//       message: json['message'],
//       data: MonthlyStatsData.fromJson(json['data']),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'status': status,
//     'message': message,
//     'data': data.toJson(),
//   };
// }
