// To parse this JSON data, do
//
//     final eventServiceBoyModel = eventServiceBoyModelFromJson(jsonString);

import 'dart:convert';

EventServiceBoyModel eventServiceBoyModelFromJson(String str) =>
    EventServiceBoyModel.fromJson(json.decode(str));

String eventServiceBoyModelToJson(EventServiceBoyModel data) => json.encode(data.toJson());

class EventServiceBoyModel {
  int? id;
  int? requirementCount;
  String? charge;
  int? eventSite;
  int? employeeType;

  EventServiceBoyModel({
    this.id,
    this.requirementCount,
    this.charge,
    this.eventSite,
    this.employeeType,
  });

  factory EventServiceBoyModel.fromJson(Map<String, dynamic> json) => EventServiceBoyModel(
        id: json["id"],
        requirementCount: json["requirement_count"],
        charge: json["charge"],
        eventSite: json["event_site"],
        employeeType: json["employee_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "requirement_count": requirementCount,
        "charge": charge,
        "event_site": eventSite,
        "employee_type": employeeType,
      };
}
