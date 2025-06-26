class ParentProfileResponse {
  final String status;
  final String message;
  final ParentData data;

  ParentProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ParentProfileResponse.fromJson(Map<String, dynamic> json) {
    return ParentProfileResponse(
      status: json['status'],
      message: json['message'].toString(), // <-- This avoids the type error
      data: ParentData.fromJson(json['data']),
    );
  }
}

class ParentData {
  final int id;
  final String name;
  final bool paid;
  final List<Child> children;

  ParentData({
    required this.id,
    required this.name,
    required this.paid,
    required this.children,
  });

  factory ParentData.fromJson(Map<String, dynamic> json) {
    return ParentData(
      id: json['id'],
      name: json['name'],
      paid: json['paid'],
      children:
          (json['children'] as List<dynamic>)
              .map((child) => Child.fromJson(child))
              .toList(),
    );
  }
}

class Child {
  final int id;
  final String name;
  final String gender;
  final int points;
  final String birthDate;
  final Character character;

  Child({
    required this.id,
    required this.name,
    required this.gender,
    required this.points,
    required this.birthDate,
    required this.character,
  });
  factory Child.fromJson(Map<String, dynamic> json) {
    final characterJson = json['character'];

    return Child(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      points: json['points'],
      birthDate: json['birth_date'],
      character:
          characterJson is Map<String, dynamic>
              ? Character.fromJson(characterJson)
              : Character.empty(), // Use empty when character is a list or null
    );
  }
}

class Character {
  final int? id;
  final String? name;
  final String? price;
  final String? image;

  Character({this.id, this.name, this.price, this.image});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }

  factory Character.empty() {
    return Character(id: null, name: '', price: '', image: '');
  }
}
