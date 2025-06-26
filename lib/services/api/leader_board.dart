import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:najati_test/config/header_config.dart';
import 'package:najati_test/core/constants/url_manager.dart';
import '../../dio_interceptor.dart';
import '../../models/top_student.dart/top.dart';

class LeaderboardService {
  final dio = DioClient.dio;

  LeaderboardService();

  Future<LeaderboardResponse> getLeaderboard(int childId) async {
    String url = "${UrlManager.leaderBoard}$childId/leaderboard";
    log(url);

    log("ekkkkkkkkkkkp");
    log(childId.toString());
    try {
      final response = await dio.get(
        url,
        options: HeaderConfig.getHeader(useToken: true),
      );

      if (response.statusCode == 200) {
        log("200");
        log(jsonEncode(response.data));
        return LeaderboardResponse.fromJson(response.data);
      } else {
        log("error ");
        throw Exception('Failed to load leaderboard');
      }
    } catch (e) {
      throw Exception('Error fetching leaderboard: $e');
    }
  }
}
