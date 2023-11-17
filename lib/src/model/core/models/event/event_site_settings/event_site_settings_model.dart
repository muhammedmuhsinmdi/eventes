import 'dart:convert';

InputEventSiteSettingsModel eventSiteSettingsModelFromJson(String str) =>
    InputEventSiteSettingsModel.fromJson(json.decode(str));

String eventSiteSettingsModelToJson(InputEventSiteSettingsModel data) => json.encode(data.toJson());

class InputEventSiteSettingsModel {
  int? id;
  int? service;
  int? eventSite;

  InputEventSiteSettingsModel({
    this.id,
    this.service,
    this.eventSite,
  });

  factory InputEventSiteSettingsModel.fromJson(Map<String, dynamic> json) => InputEventSiteSettingsModel(
        id: json["id"],
        service: json["service"],
        eventSite: json["event_site"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service": service,
        "event_site": eventSite,
      };
}
