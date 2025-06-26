class SunnahResponse {
  final String status;
  final String message;
  final SunnahData data;

  SunnahResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SunnahResponse.fromJson(Map<String, dynamic> json) {
    return SunnahResponse(
      status: json['status'],
      message: json['message'],
      data: SunnahData.fromJson(json['data']),
    );
  }
}

class SunnahData {
  final List<SunnahPrayer> rawatibSunnah;
  final List<SunnahPrayer> sunnah;

  SunnahData({required this.rawatibSunnah, required this.sunnah});

  factory SunnahData.fromJson(Map<String, dynamic> json) {
    return SunnahData(
      rawatibSunnah: List<SunnahPrayer>.from(
        json['rawatib_sunnah'].map((e) => SunnahPrayer.fromJson(e)),
      ),
      sunnah: List<SunnahPrayer>.from(
        json['sunnah'].map((e) => SunnahPrayer.fromJson(e)),
      ),
    );
  }
}

class SunnahPrayer {
  final int id;
  final String name;
  final String type;
  int isActive;

  SunnahPrayer({
    required this.id,
    required this.name,
    required this.type,
    required this.isActive,
  });

  factory SunnahPrayer.fromJson(Map<String, dynamic> json) {
    return SunnahPrayer(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      isActive: json['is_active'],
    );
  }
}
