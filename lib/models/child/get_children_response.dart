class GetChildrenResponse {
  final String status;
  final String message;
  final List<Child> data;

  GetChildrenResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetChildrenResponse.fromJson(Map<String, dynamic> json) {
    return GetChildrenResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: List<Child>.from(
        json['data'].map((child) => Child.fromJson(child)),
      ),
    );
  }
}

class Child {
  final int id;
  final String name;
  final String gender;
  final String? image;
  final int points;
  final String birthDate;
  final Character? character;

  Child({
    required this.id,
    required this.name,
    required this.gender,
    required this.image,
    required this.points,
    required this.birthDate,
    required this.character,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      image: json['image'],
      points: json['points'],
      birthDate: json['birth_date'],
      character:
          (json['character'] is Map<String, dynamic>)
              ? Character.fromJson(json['character'])
              : null,
    );
  }
}

class Character {
  final int id;
  final String name;
  final String price;
  final String? image;

  Character({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }
}
