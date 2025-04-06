import 'package:dio/dio.dart';

import '../model/register_request_model.dart';
import '../model/verify_request_model.dart';
import '../model/verify_response_model.dart';

class RegisterService {
  final Dio dio;

  RegisterService({required this.dio});

  Future<void> register(RegisterRequestModel request) async {
    try {
      await dio.post(
        "/api/register",
        data: request.toJson(),
        options: Options(contentType: "application/x-www-form-urlencoded"),
      );
    } catch (e) {
      throw Exception("Failed to register: $e");
    }
  }

  Future<VerifyResponseModel> verify(VerifyRequestModel model) async {
    try {
      final response = await dio.post(
        'your_api_endpoint_here', // replace with actual endpoint
        data: model.toFormData(),
      );

      return VerifyResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      // Convert DioError to a meaningful message or custom exception
      throw Exception(e);
    } catch (e) {
      // Any other type of error
      throw Exception('Unexpected error occurred: $e');
    }
  }
}
