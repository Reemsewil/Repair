// import 'package:dio/dio.dart';

// import '../../../../configue/configue/headre.dart';
// import '../../config/header_config.dart';
// import '../view/statistics (2).dart';

// // import '../bloc/core/constants/url_manager.dart';

// final service = WeeklyStatsService();

// void getStats() async {
//   try {
//     final stats = await service.fetchWeeklyStats();
//     print('Week starts on: ${stats.data.weekStart}');
//   } catch (e) {
//     print(e);
//   }
// }

// class WeeklyStatsService {
//   final Dio _dio;

//   WeeklyStatsService({Dio? dio}) : _dio = dio ?? Dio();

//   Future<WeeklyStatsResponse> fetchWeeklyStats() async {
//     try {
//       // final response = await _dio.get(UrlManager.getWeek);
//       final response = await _dio.get(
//         'https://najati.webmyidea.com/api/children/1/prayer-statistics/week?week=$currentWeek',
//         options: HeaderConfig.getHeader(),
//       );
//       print(currentWeek);
//       if (response.statusCode == 200) {
//         return WeeklyStatsResponse.fromJson(response.data);
//       } else {
//         throw Exception(
//           'Failed to load weekly stats, status code: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       throw Exception('Error fetching weekly stats: $e');
//     }
//   }
// }

// class WeeklyStatsResponse {
//   final String status;
//   final String message;
//   final WeeklyStatsData data;

//   WeeklyStatsResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory WeeklyStatsResponse.fromJson(Map<String, dynamic> json) {
//     return WeeklyStatsResponse(
//       status: json['status'],
//       message: json['message'],
//       data: WeeklyStatsData.fromJson(json['data']),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'status': status,
//     'message': message,
//     'data': data.toJson(),
//   };
// }

// class WeeklyStatsData {
//   final String weekStart;
//   final String weekEnd;
//   final List<DayStats> days;

//   WeeklyStatsData({
//     required this.weekStart,
//     required this.weekEnd,
//     required this.days,
//   });

//   factory WeeklyStatsData.fromJson(Map<String, dynamic> json) {
//     return WeeklyStatsData(
//       weekStart: json['week_start'],
//       weekEnd: json['week_end'],
//       days:
//           (json['days'] as List).map((day) => DayStats.fromJson(day)).toList(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'week_start': weekStart,
//     'week_end': weekEnd,
//     'days': days.map((day) => day.toJson()).toList(),
//   };
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
//               .map((p) => PrayerStatus.fromJson(p))
//               .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'date': date,
//     'prayers': prayers.map((p) => p.toJson()).toList(),
//   };
// }

// class PrayerStatus {
//   final int prayerId;
//   final String? status;

//   PrayerStatus({required this.prayerId, required this.status});

//   factory PrayerStatus.fromJson(Map<String, dynamic> json) {
//     return PrayerStatus(prayerId: json['prayer_id'], status: json['status']);
//   }

//   Map<String, dynamic> toJson() => {'prayer_id': prayerId, 'status': status};
// }
