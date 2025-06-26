// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../handling_model.dart';

class NotificationData extends ResultModel {
  final String title;

  NotificationData({required this.title});

  NotificationData copyWith({String? title}) {
    return NotificationData(title: title ?? this.title);
  }

  Map<String, dynamic> toMap() {
    return {'title': title};
  }

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(title: map['title'] as String);
  }

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData.fromMap(json);
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'NotificationData(title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationData && other.title == title;
  }

  @override
  int get hashCode => title.hashCode;
}

class NotificateModel extends ResultModel {
  final String id;
  final String time;
  final String date;
  final bool is_read;
  final NotificationData data;

  NotificateModel({
    required this.id,
    required this.time,
    required this.date,
    required this.is_read,
    required this.data,
  });

  NotificateModel copyWith({
    String? id,
    String? time,
    String? date,
    bool? is_read,
    NotificationData? data,
  }) {
    return NotificateModel(
      id: id ?? this.id,
      time: time ?? this.time,
      date: date ?? this.date,
      is_read: is_read ?? this.is_read,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
      'date': date,
      'is_read': is_read,
      'data': data.toMap(),
    };
  }

  factory NotificateModel.fromMap(Map<String, dynamic> map) {
    return NotificateModel(
      id: map['id'] as String,
      time: map['time'] as String,
      date: map['date'] as String,
      is_read: map['is_read'] as bool,
      data: NotificationData.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  factory NotificateModel.fromJson(Map<String, dynamic> json) {
    return NotificateModel.fromMap(json);
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'NotificateModel(id: $id, time: $time, date: $date, is_read: $is_read, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificateModel &&
        other.id == id &&
        other.time == time &&
        other.date == date &&
        other.is_read == is_read &&
        other.data == data;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        time.hashCode ^
        date.hashCode ^
        is_read.hashCode ^
        data.hashCode;
  }
}
