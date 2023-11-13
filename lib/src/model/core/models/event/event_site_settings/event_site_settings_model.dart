import 'dart:convert';

EventSiteSettingsModel eventSiteSettingsModelFromJson(String str) =>
    EventSiteSettingsModel.fromJson(json.decode(str));

String eventSiteSettingsModelToJson(EventSiteSettingsModel data) => json.encode(data.toJson());

class EventSiteSettingsModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? service;
  int? eventSite;

  EventSiteSettingsModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.service,
    this.eventSite,
  });

  factory EventSiteSettingsModel.fromJson(Map<String, dynamic> json) => EventSiteSettingsModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        service: json["service"],
        eventSite: json["event_site"],
      );

  Map<String, dynamic> toJson() => {
        "service": service,
      };
}
