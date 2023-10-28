// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

import 'package:evantez/src/model/core/models/event/event_site_emp_requirement/event_site_emp_req_model.dart';
import 'package:evantez/src/model/core/models/event/event_site_settings/event_site_settings_model.dart';

NewEventModel eventModelFromJson(String str) => NewEventModel.fromJson(json.decode(str));

String eventModelToJson(NewEventModel data) => json.encode(data.toJson());

class NewEventModel {
  List<EventSiteSettingsModel> eventSiteSettings;
  List<EventSiteEmployeeReqModel> eventSiteEmployeeRequirement;
  int eventTypeId;
  int venueId;
  String code;
  String customerName;
  String customerAddress;
  String customerPhone;
  String notes;
  String normalHours;
  String overtimeHourlyCharge;
  String status;

  NewEventModel({
    required this.eventSiteSettings,
    required this.eventSiteEmployeeRequirement,
    required this.eventTypeId,
    required this.venueId,
    required this.code,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.notes,
    required this.normalHours,
    required this.overtimeHourlyCharge,
    required this.status,
  });

  factory NewEventModel.fromJson(Map<String, dynamic> json) => NewEventModel(
        eventSiteSettings: List<EventSiteSettingsModel>.from(
            json["event_site_settings"].map((x) => EventSiteSettingsModel.fromJson(x))),
        eventSiteEmployeeRequirement: List<EventSiteEmployeeReqModel>.from(
            json["event_site_employee_requirement"].map((x) => EventSiteEmployeeReqModel.fromJson(x))),
        eventTypeId: json["event_type_id"],
        venueId: json["venue_id"],
        code: json["code"],
        customerName: json["customer_name"],
        customerAddress: json["customer_address"],
        customerPhone: json["customer_phone"],
        notes: json["notes"],
        normalHours: json["normal_hours"],
        overtimeHourlyCharge: json["overtime_hourly_charge"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "event_site_settings": List<dynamic>.from(eventSiteSettings.map((x) => x.toJson())),
        "event_site_employee_requirement":
            List<dynamic>.from(eventSiteEmployeeRequirement.map((x) => x.toJson())),
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
      };
}
