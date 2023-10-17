import 'dart:convert';

SettingsWageDetails settingsWageDetailsFromJson(String str) =>
    SettingsWageDetails.fromJson(json.decode(str));

String settingsWageDetailsToJson(SettingsWageDetails data) =>
    json.encode(data.toJson());

class SettingsWageDetails {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String rate;
  String code;

  SettingsWageDetails({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.rate,
    required this.code,
  });

  factory SettingsWageDetails.fromJson(Map<String, dynamic> json) =>
      SettingsWageDetails(
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
