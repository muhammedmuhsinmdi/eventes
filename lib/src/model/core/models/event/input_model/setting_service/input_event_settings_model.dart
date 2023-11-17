import 'dart:convert';

InputEventSettingsModel inputEventSettingsModelFromJson(String str) =>
    InputEventSettingsModel.fromJson(json.decode(str));

String inputEventSettingsModelToJson(InputEventSettingsModel data) => json.encode(data.toJson());

class InputEventSettingsModel {
  int id;
  int eventSite;
  int service;

  InputEventSettingsModel({
    required this.id,
    required this.eventSite,
    required this.service,
  });

  factory InputEventSettingsModel.fromJson(Map<String, dynamic> json) => InputEventSettingsModel(
        id: json["id"],
        eventSite: json["event_site"],
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_site": eventSite,
        "service": service,
      };
}
