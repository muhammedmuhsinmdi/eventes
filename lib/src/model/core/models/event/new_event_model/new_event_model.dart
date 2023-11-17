// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

import 'package:evantez/src/model/core/models/event/event_site_emp_requirement/event_site_emp_req_model.dart';
import 'package:evantez/src/model/core/models/event/event_site_settings/event_site_settings_model.dart';

NewEventModel eventModelFromJson(String str) => NewEventModel.fromJson(json.decode(str));

String eventModelToJson(NewEventModel data) => json.encode(data.toJson());

class NewEventModel {
  List<InputEventSiteSettingsModel>? eventSiteSettings;
  List<InputEventSiteEmployeeReqModel>? eventSiteEmployeeRequirement;
  int? eventTypeId;
  int? venueId;
  String? code;
  String? customerName;
  String? customerAddress;
  String? customerPhone;
  String? notes;
  String? normalHours;
  String? scheduleDateTime;
  String? overtimeHourlyCharge;
  String? status;

  NewEventModel({
    this.eventSiteSettings,
    this.eventSiteEmployeeRequirement,
    this.eventTypeId,
    this.venueId,
    this.code,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
    this.notes,
    this.normalHours,
    this.overtimeHourlyCharge,
    this.status,
    this.scheduleDateTime,
  });

  factory NewEventModel.fromJson(Map<String, dynamic> json) => NewEventModel(
      eventSiteSettings: List<InputEventSiteSettingsModel>.from(
          json["event_site_settings"].map((x) => InputEventSiteSettingsModel.fromJson(x))),
      eventSiteEmployeeRequirement: List<InputEventSiteEmployeeReqModel>.from(
          json["event_site_employee_requirement"].map((x) => InputEventSiteEmployeeReqModel.fromJson(x))),
      eventTypeId: json["event_type_id"] ?? 0,
      venueId: json["venue_id"] ?? 0,
      code: json["code"],
      customerName: json["customer_name"],
      customerAddress: json["customer_address"],
      customerPhone: json["customer_phone"],
      notes: json["notes"],
      normalHours: json["normal_hours"],
      overtimeHourlyCharge: json["overtime_hourly_charge"],
      status: json["status"],
      scheduleDateTime: json['scheduled_datetime']);

  Map<String, dynamic> toJson() => {
        "event_site_settings":
            eventSiteSettings != null ? List<dynamic>.from(eventSiteSettings!.map((x) => x.toJson())) : [],
        "event_site_employee_requirement":
            List<dynamic>.from(eventSiteEmployeeRequirement!.map((x) => x.toJson())),
        "event_type_id": eventTypeId,
        "venue_id": venueId,
        "code": code,
        "customer_name": customerName,
        "customer_address": customerAddress,
        "customer_phone": customerPhone,
        "notes": notes,
        "normal_hours": normalHours,
        "overtime_hourly_charge": overtimeHourlyCharge,
        "status": status,
        "scheduled_datetime": scheduleDateTime,
      };
}
