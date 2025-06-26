class EducationalSectionDetailResponse {
  final String status;
  final String message;
  final EducationalSectionDetail data;

  EducationalSectionDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EducationalSectionDetailResponse.fromJson(Map<String, dynamic> json) {
    return EducationalSectionDetailResponse(
      status: json['status'],
      message: json['message'],
      data: EducationalSectionDetail.fromJson(json['data']),
    );
  }
}

class EducationalSectionDetail {
  final int id;
  final String name;
  final String image;
  final List<CharacterWrapper> characters;

  EducationalSectionDetail({
    required this.id,
    required this.name,
    required this.image,
    required this.characters,
  });

  factory EducationalSectionDetail.fromJson(Map<String, dynamic> json) {
    return EducationalSectionDetail(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      characters:
          (json['characters'] as List)
              .map((e) => CharacterWrapper.fromJson(e))
              .toList(),
    );
  }
}

class CharacterWrapper {
  final CharacterModel character;
  final List<CharacterItem> items;

  CharacterWrapper({required this.character, required this.items});

  factory CharacterWrapper.fromJson(Map<String, dynamic> json) {
    return CharacterWrapper(
      character: CharacterModel.fromJson(json['character']),
      items:
          (json['items'] as List)
              .map((e) => CharacterItem.fromJson(e))
              .toList(),
    );
  }
}

class CharacterModel {
  final int id;
  final String name;
  final String price;
  final String image;

  CharacterModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }
}

class CharacterItem {
  final String image;
  final String sound;
  final String description;
  final int order;

  CharacterItem({
    required this.image,
    required this.sound,
    required this.description,
    required this.order,
  });

  factory CharacterItem.fromJson(Map<String, dynamic> json) {
    return CharacterItem(
      image: json['image'],
      sound: json['sound'],
      description: json['description'],
      order: json['order'],
    );
  }
}
