import 'dart:convert';

SettingsWageRequest settingsWageRequestFromJson(String str) =>
    SettingsWageRequest.fromJson(json.decode(str));

String settingsWageRequestToJson(SettingsWageRequest data) =>
    json.encode(data.toJson());

class SettingsWageRequest {
  String name;
  String rate;
  String code;

  SettingsWageRequest({
    required this.name,
    required this.rate,
    required this.code,
  });

  factory SettingsWageRequest.fromJson(Map<String, dynamic> json) =>
      SettingsWageRequest(
        name: json["name"],
        rate: json["rate"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rate": rate,
        "code": code,
      };
}
