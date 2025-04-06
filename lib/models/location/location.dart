class LocationResponse {
  final String status;
  final LocationData data;

  LocationResponse({required this.status, required this.data});

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      status: json['status'],
      data: LocationData.fromJson(json['data']),
    );
  }
}

class LocationData {
  final List<Governorate> governorates;

  LocationData({required this.governorates});

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      governorates:
          (json['governorates'] as List)
              .map((e) => Governorate.fromJson(e))
              .toList(),
    );
  }
}

class Governorate {
  final String name;
  final List<City> cities;

  Governorate({required this.name, required this.cities});

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      name: json['name'],
      cities: (json['cities'] as List).map((e) => City.fromJson(e)).toList(),
    );
  }
}

class City {
  final String name;
  final List<District> districts;

  City({required this.name, required this.districts});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      districts:
          (json['districts'] as List).map((e) => District.fromJson(e)).toList(),
    );
  }
}

class District {
  final String name;
  final List<Town> towns;

  District({required this.name, required this.towns});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      name: json['name'],
      towns: (json['towns'] as List).map((e) => Town.fromJson(e)).toList(),
    );
  }
}

class Town {
  final String name;

  Town({required this.name});

  factory Town.fromJson(Map<String, dynamic> json) {
    return Town(name: json['name']);
  }
}
