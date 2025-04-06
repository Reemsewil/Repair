class VerifyResponseModel {
  final String status;
  final User user;
  final Tokens tokens;

  VerifyResponseModel({
    required this.status,
    required this.user,
    required this.tokens,
  });

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyResponseModel(
      status: json['status'],
      user: User.fromJson(json['data']['user']),
      tokens: Tokens.fromJson(json['data']['tokens']),
    );
  }
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
      children: json['children'],
    );
  }
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
}
