class LeaderboardResponse {
  String status;
  String message;
  LeaderboardData data;

  LeaderboardResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LeaderboardResponse.fromJson(Map<String, dynamic> json) {
    return LeaderboardResponse(
      status: json['status'],
      message: json['message'],
      data: LeaderboardData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.toJson(),
  };
}

class LeaderboardData {
  List<LeaderboardItem> leaderboard;
  int rank;

  LeaderboardData({required this.leaderboard, required this.rank});

  factory LeaderboardData.fromJson(Map<String, dynamic> json) {
    var list = json['leaderboard'] as List<dynamic>? ?? [];
    List<LeaderboardItem> leaderboardList =
        list.map((e) => LeaderboardItem.fromJson(e)).toList();

    return LeaderboardData(
      leaderboard: leaderboardList,
      rank: json['rank'] ?? 0, // <-- fixed here
    );
  }

  Map<String, dynamic> toJson() => {
    'leaderboard': leaderboard.map((e) => e.toJson()).toList(),
    'rank': rank,
  };
}

class LeaderboardItem {
  Child child;
  Location location;

  LeaderboardItem({required this.child, required this.location});

  factory LeaderboardItem.fromJson(Map<String, dynamic> json) {
    return LeaderboardItem(
      child: Child.fromJson(json['child']),
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() => {
    'child': child.toJson(),
    'location': location.toJson(),
  };
}

class Child {
  int id;
  String name;
  String gender;
  int points;
  String birthDate;

  Child({
    required this.id,
    required this.name,
    required this.gender,
    required this.points,
    required this.birthDate,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      points: json['points'] ?? 0,
      birthDate: json['birth_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'gender': gender,
    'points': points,
    'birth_date': birthDate,
  };
}

class Location {
  String governorate;
  String city;
  String district;
  String town;

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
