// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:dio/dio.dart';
import '../../core/error/exceptions.dart';
import '../../core/success/success.dart';
import '../../models/prayers/five_prayers_response.dart';

abstract class PrayersService {
  Future<FivePrayersResponse> getFivePrayers();
}

class PrayersServiceImp implements PrayersService {
  final Dio dio;

  PrayersServiceImp({required this.dio});

  @override
  Future<FivePrayersResponse> getFivePrayers() async {
    try {
      final response = await dio.get('/api/prayers');

      if (response.statusCode == 200) {
        return FivePrayersResponse.fromJson(response.data);
      }
      throw ServerException(message: 'Failed to get prayers');
    } on DioException catch (e) {
      log('Error in getFivePrayers: ${e.message}');
      throw ServerException(message: e.message ?? 'Failed to get prayers');
    }
  }
}
