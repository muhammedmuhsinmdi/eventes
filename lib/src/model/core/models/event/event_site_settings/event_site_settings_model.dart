import 'dart:convert';

EventSiteSettingsModel eventSiteSettingsModelFromJson(String str) =>
    EventSiteSettingsModel.fromJson(json.decode(str));

String eventSiteSettingsModelToJson(EventSiteSettingsModel data) => json.encode(data.toJson());

class EventSiteSettingsModel {
  int? id;
  int? eventSite;
  int? service;

  EventSiteSettingsModel({
    this.id,
    this.eventSite,
    this.service,
  });

  factory EventSiteSettingsModel.fromJson(Map<String, dynamic> json) => EventSiteSettingsModel(
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
