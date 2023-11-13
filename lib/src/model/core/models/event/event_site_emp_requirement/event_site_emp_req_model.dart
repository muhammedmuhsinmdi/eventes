// To parse this JSON data, do
//
//     final eventSiteEmployeeRequre = eventSiteEmployeeRequreFromJson(jsonString);

import 'dart:convert';

EventSiteEmployeeReqModel eventSiteEmployeeRequreFromJson(String str) =>
    EventSiteEmployeeReqModel.fromJson(json.decode(str));

String eventSiteEmployeeRequreToJson(EventSiteEmployeeReqModel data) => json.encode(data.toJson());

class EventSiteEmployeeReqModel {
  int? requirementCount;
  int? id;
  String? charge;
  int? eventSite;
  int? employeeType;
  double get total => requirementCount! * double.parse(charge!);
  EventSiteEmployeeReqModel({
    this.requirementCount,
    this.charge,
    this.employeeType,
    this.eventSite,
    this.id,
  });

  factory EventSiteEmployeeReqModel.fromJson(Map<String, dynamic> json) => EventSiteEmployeeReqModel(
      requirementCount: json["requirement_count"],
      charge: json["charge"],
      employeeType: json["employee_type"],
      eventSite: json["event_site"],
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "requirement_count": requirementCount,
        "charge": charge,
        "employee_type": employeeType,
      };
}
