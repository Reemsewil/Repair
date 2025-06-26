import 'package:hive/hive.dart';

import 'send_prayer_status_response.dart';

part 'attendance_hive_model.g.dart';

@HiveType(typeId: 0)
class Attendance extends HiveObject {
  @HiveField(0)
  int childId;

  @HiveField(1)
  int prayerId;

  @HiveField(2)
  int status;

  @HiveField(3)
  DateTime datetime;

  Attendance({
    required this.childId,
    required this.prayerId,
    required this.status,
    required this.datetime,
  });

  // Optional: convert from/to API model
  factory Attendance.fromModel(AttendanceModel model) {
    return Attendance(
      childId: model.childId,
      prayerId: model.prayerId,
      status: model.status,
      datetime: model.datetime,
    );
  }

  AttendanceModel toModel() {
    return AttendanceModel(
      childId: childId,
      prayerId: prayerId,
      status: status,
      datetime: datetime,
    );
  }

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      childId: json['child_id'],
      prayerId: json['prayer_id'],
      status: json['status'],
      datetime: DateTime.parse(json['datetime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'child_id': childId,
      'prayer_id': prayerId,
      'status': status,
      'datetime': datetime.toIso8601String(),
    };
  }
}
