// To parse this JSON data, do
//
//     final eventSiteEmployeeRequre = eventSiteEmployeeRequreFromJson(jsonString);

import 'dart:convert';

InputEventSiteEmployeeReqModel eventSiteEmployeeRequreFromJson(String str) =>
    InputEventSiteEmployeeReqModel.fromJson(json.decode(str));

String eventSiteEmployeeRequreToJson(InputEventSiteEmployeeReqModel data) => json.encode(data.toJson());

class InputEventSiteEmployeeReqModel {
  int? requirementCount;
  int? id;
  String? charge;
  int? eventSite;
  int? employeeType;
  double get total => requirementCount! * double.parse(charge!);
  InputEventSiteEmployeeReqModel({
    this.requirementCount,
    this.charge,
    this.employeeType,
    this.eventSite,
    this.id,
  });

  factory InputEventSiteEmployeeReqModel.fromJson(Map<String, dynamic> json) =>
      InputEventSiteEmployeeReqModel(
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
