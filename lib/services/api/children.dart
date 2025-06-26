import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import '../../config/header_config.dart';
import '../../core/constants/url_manager.dart';
import '../../core/error/exceptions.dart';
import '../../core/success/success.dart';
import '../../dio_interceptor.dart';
import '../../models/child/create_child_response.dart';
import '../../models/child/get_children_response.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

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
  final dio = DioClient.dio;

  ChildrenServiceImp();
  @override
  Future<CreateChildResponse> createChild({
    required String name,
    required String gender,
    required String birthDate,
    required String imagePath,
  }) async {
    try {
      log("🔔 Started createChild()");
      log("📍 API URL: ${UrlManager.createChild}");
      log("📦 Image asset path: $imagePath");

      // 🔧 Helper to convert asset image to a File
      log("✅ File ready at:");
      final formData = FormData.fromMap({
        'name': name,
        'gender': gender,
        'birth_date': birthDate,
        // 'image': await MultipartFile.fromFile(file.path),
      });

      // Log fields manually
      log("name: ${formData.fields.firstWhere((f) => f.key == 'name').value}");
      log(
        "gender: ${formData.fields.firstWhere((f) => f.key == 'gender').value}",
      );
      log(
        "birth_date: ${formData.fields.firstWhere((f) => f.key == 'birth_date').value}",
      );

      log("✅ File ready at: ${formData}");
      log("📤 Sending request to create child...");

      final response = await dio.post(
        UrlManager.createChild,
        options: HeaderConfig.getHeader(useToken: true),
        data: formData,
      );

      if (response.statusCode == 200) {
        log("✅ Request successful, parsing response...");
        return CreateChildResponse.fromJson(response.data);
      } else if (response.statusCode == 400) {
        // Bad request
        log("⚠️ Bad request - 400");
        throw ServerException(
          message: response.data['message'] ?? "طلب غير صالح",
        );
      } else if (response.statusCode == 401) {
        // Unauthorized
        log("⚠️ Unauthorized - 401");
        throw ServerException(message: "غير مخول، يرجى تسجيل الدخول");
      } else if (response.statusCode == 500) {
        // Server error
        log("⚠️ Server error - 500");
        throw ServerException(message: "خطأ في الخادم، يرجى المحاولة لاحقا");
      } else {
        // Other unexpected statuses
        log("⚠️ Unexpected status code: ${response.statusCode}");
        throw ServerException(
          message: "حدث خطأ غير متوقع (رمز الحالة: ${response.statusCode})",
        );
      }
    } on DioException catch (e) {
      log("❌ DioException occurred");
      log("❌ Message: ${e.message}");
      log("❌ Response data: ${e.response?.data}");

      throw ServerException(
        message:
            e.response?.data['message'] ??
            'حدث خطأ أثناء إنشاء حساب لطفلك يرجى المحاولة لاحقا',
      );
    } catch (e, stack) {
      log("❌ Unexpected Error: $e");
      log("📄 Stacktrace:\n$stack");
      throw ServerException(message: 'حدث خطأ غير متوقع');
    }
  }

  @override
  Future<GetChildrenResponse> getChildren() async {
    try {
      log("🔔 Started getChildren()");
      log("📍 API URL: ${UrlManager.getChildren}");

      final response = await dio.get(
        UrlManager.getChildren,
        options: HeaderConfig.getHeader(useToken: true),
      );
      log("📶 Status code: ${response.statusCode}");
      log("📦 Full response: ${jsonEncode(response.data)}");

      if (response.statusCode == 200) {
        log(response.data.toString());
        log("✅ Request successful, parsing response...");
        return GetChildrenResponse.fromJson(response.data);
      } else if (response.statusCode == 400) {
        log("⚠️ Bad request - 400");
        throw ServerException(
          message: response.data['message'] ?? "طلب غير صالح",
        );
      } else if (response.statusCode == 401) {
        log("⚠️ Unauthorized - 401");
        throw ServerException(message: "غير مخول، يرجى تسجيل الدخول");
      } else if (response.statusCode == 404) {
        log("⚠️ Not found - 404");
        throw ServerException(message: "المورد غير موجود");
      } else if (response.statusCode == 500) {
        log("⚠️ Server error - 500");
        throw ServerException(message: "خطأ في الخادم، يرجى المحاولة لاحقًا");
      } else {
        log("⚠️ Unexpected status code: ${response.statusCode}");
        throw ServerException(
          message: "حدث خطأ غير متوقع (رمز الحالة: ${response.statusCode})",
        );
      }
    } on DioException catch (e) {
      log("❌ DioException occurred");
      log("❌ Message: ${e.message}");
      log("❌ Status code: ${e.response?.statusCode}");
      log("❌ Response data: ${e.response?.data}");

      throw ServerException(
        message: e.response?.data['message'] ?? 'فشل في تحميل قائمة الأبناء',
      );
    } catch (e, stack) {
      log("❌ Unexpected Error: $e");
      log("📄 Stacktrace:\n$stack");
      throw ServerException(message: 'حدث خطأ غير متوقع');
    }
  }
}
