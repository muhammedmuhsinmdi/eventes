// To parse this JSON data, do
//
//     final eventSiteEmployeeRequre = eventSiteEmployeeRequreFromJson(jsonString);

import 'dart:convert';

EventSiteEmployeeReqModel eventSiteEmployeeRequreFromJson(String str) =>
    EventSiteEmployeeReqModel.fromJson(json.decode(str));

String eventSiteEmployeeRequreToJson(EventSiteEmployeeReqModel data) => json.encode(data.toJson());

class EventSiteEmployeeReqModel {
  int? id;
  int? requirementCount;
  String? charge;
  int? eventSite;
  int? employeeType;

  EventSiteEmployeeReqModel({
    this.id,
    this.requirementCount,
    this.charge,
    this.eventSite,
    this.employeeType,
  });

  factory EventSiteEmployeeReqModel.fromJson(Map<String, dynamic> json) => EventSiteEmployeeReqModel(
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
