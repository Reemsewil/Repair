// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:dio/dio.dart';
import '../../config/header_config.dart';
import '../../core/constants/url_manager.dart';
import '../../core/error/exceptions.dart';
import '../../core/success/success.dart';
import '../../dio_interceptor.dart';
import '../../models/prayer_times/get_prayer_times.dart';

abstract class PrayerTimesService {
  Future<GetPrayerTimesResponse> getPrayerTimes();
}

class PrayerTimesServiceImp implements PrayerTimesService {
  final dio = DioClient.dio;

  PrayerTimesServiceImp();

  @override
  Future<GetPrayerTimesResponse> getPrayerTimes() async {
    try {
      final response = await dio.get(
        UrlManager.getPrayerTimes,
        options: HeaderConfig.getHeader(useToken: true),
      );

      if (response.statusCode == 200) {
        log("the request successsssssss");
        log("++++++++++++++");
        return GetPrayerTimesResponse.fromJson(response.data);
      }
      log("++++++++00000000000++++++");

      throw ServerException(message: 'Failed to get prayer times');
    } on DioException catch (e) {
      log("++++++++++++tttttttttttttttt++");

      log('Error in getPrayerTimes: ${e.message}');
      throw ServerException(message: e.message ?? 'Failed to get prayer times');
    }
  }
}
