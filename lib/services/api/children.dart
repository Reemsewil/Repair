// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:dio/dio.dart';
import '../../core/error/exceptions.dart';
import '../../core/success/success.dart';
import '../../models/child/create_child_response.dart';
import '../../models/child/get_children_response.dart';

abstract class ChildrenService {
  Future<CreateChildResponse> createChild({
    required String name,
    required String gender,
    required String birthDate,
    required String imagePath,
  });
  Future<GetChildrenResponse> getChildren();
}

class ChildrenServiceImp implements ChildrenService {
  final Dio dio;

  ChildrenServiceImp({required this.dio});

  @override
  Future<CreateChildResponse> createChild({
    required String name,
    required String gender,
    required String birthDate,
    required String imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'gender': gender,
        'birth_date': birthDate,
        'image': await MultipartFile.fromFile(imagePath),
      });

      final response = await dio.post('/api/children', data: formData);

      if (response.statusCode == 200) {
        return CreateChildResponse.fromJson(response.data);
      }
      throw ServerException(message: 'Failed to create child');
    } on DioException catch (e) {
      log('Error in createChild: ${e.message}');
      throw ServerException(message: e.message ?? 'Failed to create child');
    }
  }

  @override
  Future<GetChildrenResponse> getChildren() async {
    try {
      final response = await dio.get('/api/children');

      if (response.statusCode == 200) {
        return GetChildrenResponse.fromJson(response.data);
      }
      throw ServerException(message: 'Failed to get children');
    } on DioException catch (e) {
      log('Error in getChildren: ${e.message}');
      throw ServerException(message: e.message ?? 'Failed to get children');
    }
  }
}
