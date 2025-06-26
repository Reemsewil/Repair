// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import '../../config/header_config.dart';
import '../../core/constants/url_manager.dart';
import '../../core/error/exceptions.dart';
import '../../core/success/success.dart';
import '../../dio_interceptor.dart';
import '../../models/educational_section/get_all_stories_response.dart';
import '../../models/educational_section/get_story_response.dart';

abstract class EducationalSectionService {
  Future<GetAllStoriesResponse> getAllStories();
  Future<EducationalSectionDetailResponse> getStory({required int storyId});
}

class EducationalSectionServiceImp implements EducationalSectionService {
  final dio = DioClient.dio;

  EducationalSectionServiceImp();

  @override
  Future<GetAllStoriesResponse> getAllStories() async {
    try {
      print("h11111111111111111888888888888888888===============i");
      final response = await dio.get(
        UrlManager.getSectionStory,
        options: HeaderConfig.getHeader(useToken: true),
      );

      if (response.statusCode == 200) {
        print("hiiiiiiiii============================i");
        log(jsonEncode(response.data));

        return GetAllStoriesResponse.fromJson(response.data);
      }
      print("hiiiiiiiii============================i");
      throw ServerException(message: 'Failed to get stories');
    } on DioException catch (e) {
      log('Error in getAllStories: ${e.message}');
      throw ServerException(message: e.message ?? 'Failed to get stories');
    }
  }

  // @override
  // Future<GetStoryResponse> getStory({required int storyId}) async {
  //   try {
  //     log("hiuunhhg======================ssxcsdcdfvgf");
  //     final response = await dio.get(
  //       "${UrlManager.getStoryFromId}$storyId",
  //       options: HeaderConfig.getHeader(useToken: true),
  //     );

  //     if (response.statusCode == 200) {
  //       log("hiuunhhghbfققققققققققققققققققققققققققققققققققvgf");
  //       return GetStoryResponse.fromJson(response.data);
  //     }
  //     log("hiuunhh00000000000000000000000000000000000000000vgf");
  //     throw ServerException(message: 'Failed to get story');
  //   } on DioException catch (e) {
  //     log('Error in getStory: ${e.message}');
  //     throw ServerException(message: e.message ?? 'Failed to get story');
  //   }
  // }
  @override
  Future<EducationalSectionDetailResponse> getStory({
    required int storyId,
  }) async {
    try {
      log("Calling getStory...");
      final response = await dio.get(
        "${UrlManager.getStoryFromId}$storyId",
        options: HeaderConfig.getHeader(useToken: true),
      );

      if (response.statusCode == 200) {
        log(jsonEncode(response.data));

        return EducationalSectionDetailResponse.fromJson(response.data);
      }

      throw ServerException(message: 'Failed to get story');
    } on DioException catch (e) {
      log('Error in getStory: ${e.message}');
      throw ServerException(message: e.message ?? 'Failed to get story');
    }
  }
}
