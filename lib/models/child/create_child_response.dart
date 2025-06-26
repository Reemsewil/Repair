class CreateChildResponse {
  final String status;
  final String message;
  final Child data;

  CreateChildResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateChildResponse.fromJson(Map<String, dynamic> json) {
    return CreateChildResponse(
      status: json['status'],
      message: json['message'],
      data: Child.fromJson(json['data']),
    );
  }
}

class Child {
  final int id;
  final String name;
  final String gender;
  final int points;
  final String birthDate;
  final List<dynamic> character;

  Child({
    required this.id,
    required this.name,
    required this.gender,
    required this.points,
    required this.birthDate,
    required this.character,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      points: json['points'],
      birthDate: json['birth_date'],
      character: List<dynamic>.from(json['character']),
    );
  }
}
