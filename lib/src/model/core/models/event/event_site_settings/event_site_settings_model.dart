import 'dart:convert';

EventSiteSettingsModel eventSiteSettingsModelFromJson(String str) =>
    EventSiteSettingsModel.fromJson(json.decode(str));

String eventSiteSettingsModelToJson(EventSiteSettingsModel data) => json.encode(data.toJson());

class EventSiteSettingsModel {
  int? service;

  EventSiteSettingsModel({
    this.service,
  });

  factory EventSiteSettingsModel.fromJson(Map<String, dynamic> json) => EventSiteSettingsModel(
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "service": service,
      };
}
