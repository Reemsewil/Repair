class AttendanceModel {
  final int childId;
  final int prayerId;
  final int status;
  final DateTime datetime;

  AttendanceModel({
    required this.childId,
    required this.prayerId,
    required this.status,
    required this.datetime,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
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

class AttendancesRequest {
  final List<AttendanceModel> attendances;

  AttendancesRequest({required this.attendances});

  Map<String, dynamic> toJson() {
    return {'attendances': attendances.map((e) => e.toJson()).toList()};
  }
}
