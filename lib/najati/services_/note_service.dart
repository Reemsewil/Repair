import 'package:dio/dio.dart';

import '../../config/header_config.dart';
import '../../core_service.dart';
import '../../handling_model.dart';
import '../notific_/model/notificate_model.dart';

abstract class NoteService extends CoreService {
  Future<ResultModel> getNote();
}

class NoteServiceImp extends NoteService {
  @override
  Future<ResultModel> getNote() async {
    try {
      response = await dio.get(
        'https://najati.webmyidea.com/api/notifications',
        options: HeaderConfig.getHeader(useToken: true),
      );
      List<NotificateModel> notificate = List.generate(
        response.data['data'].length,
        (index) => NotificateModel.fromJson(response.data['data'][index]),
      );
      print(notificate);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return ListOf(data: notificate);
      } else {
        return ErrorModel();
      }
    } on DioException catch (e) {
      print(e.message);
      return ExceptionModel(message: e.message);
    }
  }
}
