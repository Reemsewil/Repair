// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:dio/dio.dart';
import '../../config/header_config.dart';
import '../../core/constants/url_manager.dart';
import '../../core/error/exceptions.dart';
import '../../dio_interceptor.dart';
import '../../models/charachter_model.dart';

abstract class CharachterService {
  Future<bool> createCharachter({required int num, required int childId});
  Future<GetCharacters> getCharachters();
}

class CharacterServiceImp implements CharachterService {
  final dio = DioClient.dio;

  CharacterServiceImp();
  @override
  Future<bool> createCharachter({
    required int num,
    required int childId,
  }) async {
    try {
      log("hiuunhhghbfbggvfgdcfgssxcsdcdfvgf");
      log('${UrlManager.baseUrl}/api/children/$childId/choose_character/$num');
      final response = await dio.post(
        '${UrlManager.baseUrl}/api/children/$childId/choose_character/$num',
        options: HeaderConfig.getHeader(useToken: true),
      );
      if (response.statusCode == 200) {
        log("================================================");
        return response.statusCode == 200;
      } else {
        log("++++++++++++++++++++++++++++++++++++++++++++++++");
        throw ServerException(message: 'حدث خطأ أثناء جلب الشخصيات');
      }
    } on DioException catch (e) {
      log("+=+++_))(***********************)");
      log('Error in createCharacter: ${e.message}');
      throw ServerException(
        message:
            e.message ??
            'حدث خطأ أثناء إنشاء كاركتر لطفلك يرجى المحاولة لاحقاً',
      );
    }
  }

  @override
  Future<GetCharacters> getCharachters() async {
    try {
      log("hiuunhhghbfbggvfgdcfgssxcsdcdfvgf");
      final response = await dio.get(
        UrlManager.getCharachters,
        options: HeaderConfig.getHeader(useToken: true),
      );

      if (response.statusCode == 200) {
        log("================================================");
        return GetCharacters.fromJson(response.data);
      } else {
        log("++++++++++++++++++++++++++++++++++++++++++++++++");
        throw ServerException(message: 'حدث خطأ أثناء جلب الشخصيات');
      }
    } on DioException catch (e) {
      log("+=+++_))(***********************)");
      throw ServerException(
        message: e.message ?? 'فشل الاتصال بالخادم. حاول لاحقاً.',
      );
    }
  }
}
