import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import 'dio_interceptor.dart';

abstract class CoreService {
  final dio = DioClient.dio;
  late Response response;
  String baseUrl = "https://najati.webmyidea.com/api/dashboard/";
}

//   CoreService() {
//     dio.options.baseUrl = baseUrl;
//     dio.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         final token = await getAccessToken();
//         if (token != null) {
//           options.headers['Authorization'] = 'Bearer $token';
//         }
//         return handler.next(options);
//       },
//       onError: (e, handler) async {
//         if (e.response?.statusCode == 401) {
//           final newToken = await refreshToken();
//           if (newToken != null) {
//             final opts = e.requestOptions;
//             opts.headers['Authorization'] = 'Bearer $newToken';
//             final cloneReq = await dio.fetch(opts);
//             return handler.resolve(cloneReq);
//           }
//         }
//         return handler.next(e);
//       },
//     ));
//   }

//   Future<String?> getAccessToken() async {
//     final box = Hive.box('authBox');
//     return box.get('accessToken');
//   }

//   Future<String?> getStoredRefreshToken() async {
//     final box = Hive.box('authBox');
//     return box.get('refreshToken');
//   }

//   Future<void> storeTokens(String accessToken, String refreshToken) async {
//     final box = Hive.box('authBox');
//     await box.put('accessToken', accessToken);
//     await box.put('refreshToken', refreshToken);
//   }

//   Future<String?> refreshToken() async {
//     try {
//       final refreshToken = await getStoredRefreshToken();
//       if (refreshToken == null) return null;

//       final response = await dio.post(
//         'https://najati.webmyidea.com/api/refresh-token', // هل الرابط صحيح
//         data: {
//           'refresh_token': refreshToken,
//         },
//       );

//       final newAccessToken = response.data['access_token'];
//       final newRefreshToken = response.data['refresh_token'];

//       await storeTokens(newAccessToken, newRefreshToken);

//       return newAccessToken;
//     } catch (e) {
//       print("Refresh token failed: $e");
//       return null;
//     }
//   }
// }
