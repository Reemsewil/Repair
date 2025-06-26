import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'core/constants/url_manager.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      //  baseUrl: UrlManager.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  static Dio get dio => _dio;

  static void init() {
    _dio.interceptors.clear();

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // استدعاء التوكن من Hive وإضافته في الهيدر
          final authBox = Hive.box('authBox');
          final accessToken = authBox.get('accessToken');
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          final authBox = Hive.box('authBox');

          // إذا الرد 401 والطلب ليس طلب تحديث التوكن
          if (error.response?.statusCode == 401 &&
              !error.requestOptions.path.contains('/refresh-token')) {
            final refreshToken = authBox.get('refreshToken');

            if (refreshToken == null) {
              // لا يوجد توكن تحديث => أعد الرفض واطلب تسجيل دخول جديد
              return handler.reject(error);
            }

            try {
              // طلب تحديث التوكن
              final response = await _dio.post(
                UrlManager.refreshToken,
                data: {"refresh_token": refreshToken},
              );

              // جلب التوكنات الجديدة
              final newAccessToken = response.data['access_token'];
              final newRefreshToken = response.data['refresh_token'];

              // حفظها في التخزين المحلي
              await authBox.put('accessToken', newAccessToken);
              await authBox.put('refreshToken', newRefreshToken);

              // تحديث هيدر الطلب الأصلي بالتوكن الجديد
              final options = error.requestOptions;
              options.headers['Authorization'] = 'Bearer $newAccessToken';

              // إعادة تنفيذ الطلب الأصلي
              final retryResponse = await _dio.fetch(options);
              return handler.resolve(retryResponse);
            } catch (e) {
              // فشل تحديث التوكن => حذف التوكنات ورفض الخطأ
              await authBox.delete('accessToken');
              await authBox.delete('refreshToken');
              return handler.reject(error);
            }
          }

          return handler.next(error);
        },
      ),
    );
  }
}
