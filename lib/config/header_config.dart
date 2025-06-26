import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

// box.get('token')
class HeaderConfig {
  static Options getHeader({useToken = true}) {
    var box = Hive.box('authBox');
    //
    if (useToken) {
      return Options(
        headers: {
          "accept": "*/*",
          "Authorization":
              // "Bearer 33|0zttjdpD3zpGx59HSRLMRqnEnWHRUAVUtwaErO2oa6de5486",
              "Bearer ${box.get('accessToken')}",
        },
      );
    } else {
      return Options(headers: {"Content-Type": "application/json"});
    }
  }
}
