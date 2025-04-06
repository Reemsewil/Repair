class GetChildrenResponse {
  final String status;
  final List<ChildData> data;

  GetChildrenResponse({required this.status, required this.data});

  factory GetChildrenResponse.fromJson(Map<String, dynamic> json) {
    return GetChildrenResponse(
      status: json['status'],
      data:
          (json['data'] as List)
              .map((item) => ChildData.fromJson(item))
              .toList(),
    );
  }
}

class ChildData {
  final int id;
  final String name;
  final String gender;
  final String image;
  final int points;
  final String birthDate;
  final bool subscribed;
  final List<dynamic> character;

  ChildData({
    required this.id,
    required this.name,
    required this.gender,
    required this.image,
    required this.points,
    required this.birthDate,
    required this.subscribed,
    required this.character,
  });

  factory ChildData.fromJson(Map<String, dynamic> json) {
    return ChildData(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      image: json['image'],
      points: json['points'],
      birthDate: json['birth_date'],
      subscribed: json['subscribed'],
      character: json['character'] as List<dynamic>,
    );
  }
}
