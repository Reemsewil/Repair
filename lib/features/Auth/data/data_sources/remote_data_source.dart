import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:najati_test/core/constants/url_manager.dart';

import '../../../../dio_interceptor.dart';
import '../model/register_request_model.dart';
import '../model/verify_request_model.dart';
import '../model/verify_response_model.dart';

class RegisterService {
  final dio = Dio();

  RegisterService();

  Future<bool> register(RegisterRequestModel request) async {
    print("$request.");
    log("hellllllllllllllo");

    try {
      final response = await dio.post(
        UrlManager.register,
        data: request.toJson(),
        options: Options(contentType: "application/x-www-form-urlencoded"),
      );

      if (response.statusCode == 200) {
        print("hiii");
        return true;
      } else {
        print("Unexpected status code: ${response.statusCode}");
        return false;
      }
    } on DioException catch (dioError) {
      // Dio-specific error handling
      if (dioError.type == DioExceptionType.connectionTimeout) {
        print("Connection timeout");
      } else if (dioError.type == DioExceptionType.sendTimeout) {
        print("Send timeout");
      } else if (dioError.type == DioExceptionType.receiveTimeout) {
        print("Receive timeout");
      } else if (dioError.type == DioExceptionType.badResponse) {
        print(
          "Server responded with an error: ${dioError.response?.statusCode}",
        );
      } else if (dioError.type == DioExceptionType.cancel) {
        print("Request was cancelled");
      } else if (dioError.type == DioExceptionType.connectionError) {
        print("No internet connection");
      } else {
        print("Unexpected Dio error: ${dioError.message}");
      }

      return false;
    } catch (e, stack) {
      print("Unexpected error: $e");
      log(stack.toString());
      return false;
    }
  }

  Future<dynamic> verify(Map<String, dynamic> model) async {
    try {
      VerifyResponseModel result;
      FormData formData = FormData.fromMap(model);
      print('🔗 URL: ${UrlManager.verify}');
      print("📦 Model to send: $model");

      final response = await dio.post(
        UrlManager.verify,
        data: formData,
        //  options: Options(headers: {'Content-Type': 'application/json'}),
      );
      log("${response.statusCode}");
      print("$response");
      final data = response.data;
      result = VerifyResponseModel.fromJson(data);
      print("$result");
      // Check status key and handle accordingly
      if (result.status == 'success') {
        // Store tokens in Hive
        final authBox = Hive.box('authBox');
        authBox.put('accessToken', result.data!.tokens.accessToken);
        authBox.put('refreshToken', result.data!.tokens.refreshToken);

        return result;
      } else {
        return result.message;
      }
    } on DioException catch (e) {
      print("❌ Dio Error: ${e.response}");
      print("❌ Dio Error data: ${e.response?.data}");
      print("❌ Dio Error message: ${e.message}");
    }
  }
}
