import 'dart:convert';

InputEventSiteSettingsModel inputEventSiteSettingsModelFromJson(String str) =>
    InputEventSiteSettingsModel.fromJson(json.decode(str));

String inputEventSiteSettingsModelToJson(InputEventSiteSettingsModel data) => json.encode(data.toJson());

class InputEventSiteSettingsModel {
  int id;
  String name;
  String rate;
  String code;

  InputEventSiteSettingsModel({
    required this.id,
    required this.name,
    required this.rate,
    required this.code,
  });

  factory InputEventSiteSettingsModel.fromJson(Map<String, dynamic> json) => InputEventSiteSettingsModel(
        id: json["id"],
        name: json["name"],
        rate: json["rate"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rate": rate,
        "code": code,
      };
}
