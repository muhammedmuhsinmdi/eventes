// To parse this JSON data, do
//
//     final eventSiteEmployeeRequre = eventSiteEmployeeRequreFromJson(jsonString);

import 'dart:convert';

EventSiteEmployeeReqModel eventSiteEmployeeRequreFromJson(String str) =>
    EventSiteEmployeeReqModel.fromJson(json.decode(str));

String eventSiteEmployeeRequreToJson(EventSiteEmployeeReqModel data) => json.encode(data.toJson());

class EventSiteEmployeeReqModel {
  int? requirementCount;
  String? charge;
  int? employeeType;

  EventSiteEmployeeReqModel({
    this.requirementCount,
    this.charge,
    this.employeeType,
  });

  factory EventSiteEmployeeReqModel.fromJson(Map<String, dynamic> json) => EventSiteEmployeeReqModel(
        requirementCount: json["requirement_count"],
        charge: json["charge"],
        employeeType: json["employee_type"],
      );

  Map<String, dynamic> toJson() => {
        "requirement_count": requirementCount,
        "charge": charge,
        "employee_type": employeeType,
      };
}
