import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:najati_test/config/header_config.dart';

import '../../core/constants/url_manager.dart';
import '../../dio_interceptor.dart';
import '../../models/profile_settings.dart';

class ParentProfileService {
  final dio = DioClient.dio;

  ParentProfileService();

  Future<ParentProfileResponse> fetchParentProfile() async {
    try {
      final response = await dio.get(
        UrlManager.settings,
        options: HeaderConfig.getHeader(useToken: true),
      );
      log("=========================");
      log(response.data.toString());
      if (response.statusCode == 200) {
        return ParentProfileResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to load parent profile. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching parent profile: $e');
    }
  }
}
