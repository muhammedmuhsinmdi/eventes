import 'dart:convert';

SettingsWageListResponse settingsWageListResponseFromJson(String str) =>
    SettingsWageListResponse.fromJson(json.decode(str));

String settingsWageListResponseToJson(SettingsWageListResponse data) =>
    json.encode(data.toJson());

class SettingsWageListResponse {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String rate;
  String code;

  SettingsWageListResponse({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.rate,
    required this.code,
  });

  factory SettingsWageListResponse.fromJson(Map<String, dynamic> json) =>
      SettingsWageListResponse(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        rate: json["rate"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "rate": rate,
        "code": code,
      };
}
