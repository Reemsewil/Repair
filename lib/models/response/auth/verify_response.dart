class VerifyResponseModel {
  final String status;
  final VerifyData data;

  VerifyResponseModel({required this.status, required this.data});

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyResponseModel(
      status: json['status'] ?? '',
      data: VerifyData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {'status': status, 'data': data.toJson()};
}

class VerifyData {
  final User user;
  final Tokens tokens;

  VerifyData({required this.user, required this.tokens});

  factory VerifyData.fromJson(Map<String, dynamic> json) {
    return VerifyData(
      user: User.fromJson(json['user']),
      tokens: Tokens.fromJson(json['tokens']),
    );
  }

  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'tokens': tokens.toJson(),
  };
}

class User {
  final int id;
  final String name;
  final String phone;
  final Location location;
  final List<dynamic> children;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.location,
    required this.children,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      location: Location.fromJson(json['location']),
      children: List<dynamic>.from(json['children']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'location': location.toJson(),
    'children': children,
  };
}

class Location {
  final String governorate;
  final String city;
  final String district;
  final String town;

  Location({
    required this.governorate,
    required this.city,
    required this.district,
    required this.town,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      governorate: json['governorate'],
      city: json['city'],
      district: json['district'],
      town: json['town'],
    );
  }

  Map<String, dynamic> toJson() => {
    'governorate': governorate,
    'city': city,
    'district': district,
    'town': town,
  };
}

class Tokens {
  final String accessToken;
  final String refreshToken;

  Tokens({required this.accessToken, required this.refreshToken});

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'refresh_token': refreshToken,
  };
}
