class ResultModel{}
class ListOf<T> extends ResultModel{
  List<T> data;
  ListOf({required this.data});
}

class OneModel<T> extends ResultModel{
  T? data;
  OneModel({required this.data});

}
class ErrorModel extends ResultModel{}
class ExceptionModel extends ResultModel{
  final message;
  ExceptionModel({required this.message});
}
class DataSuccess extends ResultModel {}