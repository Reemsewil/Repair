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
      // log(response.);

      if (response.statusCode == 200) {
        log("the request successsssssss");
        log("++++++++++++++");
        return GetPrayerTimesResponse.fromJson(response.data);
      }
      log("++++++++00000000000++++++");
      log(response.data);
      throw ServerException(message: 'Failed to get prayer times');
    } on DioException catch (e) {
      log("++++++++++++tttttttttttttttt++");

      log('Error in getPrayerTimes: ${e.message}');
      throw ServerException(message: e.message ?? 'Failed to get prayer times');
    }
  }
}

class PrayerTimesServiceMock implements PrayerTimesService {
  @override
  Future<GetPrayerTimesResponse> getPrayerTimes() async {
    // Just fake data
    return GetPrayerTimesResponse(
      status: "success",
      data: PrayerData(
        date: "2025-08-29",
        prayerTimes: PrayerTimes(
          fajr: "04:15",
          sunrise: "06:10",
          dhuhr: "12:30",
          asr: "16:15",
          sunset: "18:50",
          maghrib: "19:05",
          isha: "20:35",
          imsak: "04:00",
          midnight: "23:59",
          firstThird: "21:00",
          lastThird: "03:00",
        ),
      ),
    );
  }
}
