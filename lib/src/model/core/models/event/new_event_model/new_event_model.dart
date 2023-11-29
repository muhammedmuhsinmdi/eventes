// To parse this JSON data, do
//
//     final newEventModel = newEventModelFromJson(jsonString);

import 'dart:convert';

NewEventModel newEventModelFromJson(String str) => NewEventModel.fromJson(json.decode(str));

String newEventModelToJson(NewEventModel data) => json.encode(data.toJson());

class NewEventModel {
  int? eventTypeId;
  int? venueId;
  String? scheduledDatetime;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  String? notes;
  String? normalHours;
  String? overtimeHourlyCharge;
  List<EventSiteSetting>? eventSiteSettings;
  List<EventSiteEmployeeRequirement>? eventSiteEmployeeRequirement;
  String? status;
  int? progress;
  String? rating;

  NewEventModel({
    this.eventTypeId,
    this.venueId,
    this.scheduledDatetime,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.notes,
    this.normalHours,
    this.overtimeHourlyCharge,
    this.eventSiteSettings,
    this.eventSiteEmployeeRequirement,
    this.status,
    this.progress,
    this.rating,
  });

  factory NewEventModel.fromJson(Map<String, dynamic> json) => NewEventModel(
      eventTypeId: json["event_type_id"],
      venueId: json["venue_id"],
      scheduledDatetime: json["scheduled_datetime"],
      customerName: json["customer_name"],
      customerPhone: json["customer_phone"],
      customerAddress: json["customer_address"],
      notes: json["notes"],
      normalHours: json["normal_hours"],
      overtimeHourlyCharge: json["overtime_hourly_charge"],
      eventSiteSettings:
          List<EventSiteSetting>.from(json["event_site_settings"].map((x) => EventSiteSetting.fromJson(x))),
      eventSiteEmployeeRequirement: List<EventSiteEmployeeRequirement>.from(
          json["event_site_employee_requirement"].map((x) => EventSiteEmployeeRequirement.fromJson(x))),
      status: json["status"],
      progress: json["progress"],
      rating: json["rating"]);

  Map<String, dynamic> toJson() => {
        "event_type_id": eventTypeId,
        "venue_id": venueId,
        "scheduled_datetime": scheduledDatetime,
        "customer_name": customerName,
        "customer_phone": customerPhone,
        "customer_address": customerAddress,
        "notes": notes,
        "normal_hours": normalHours,
        "overtime_hourly_charge": overtimeHourlyCharge,
        "event_site_settings": List<dynamic>.from(eventSiteSettings!.map((x) => x.toJson())),
        "event_site_employee_requirement":
            List<dynamic>.from(eventSiteEmployeeRequirement!.map((x) => x.toJson())),
        "status": status,
        "progress": progress ?? 0,
        "rating": rating
      };
}

class EventSiteEmployeeRequirement {
  int? requirementCount;
  String? charge;
  int? employeeType;

  EventSiteEmployeeRequirement({
    this.requirementCount,
    this.charge,
    this.employeeType,
  });

  factory EventSiteEmployeeRequirement.fromJson(Map<String, dynamic> json) => EventSiteEmployeeRequirement(
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

class EventSiteSetting {
  int? service;

  EventSiteSetting({
    this.service,
  });

  factory EventSiteSetting.fromJson(Map<String, dynamic> json) => EventSiteSetting(
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "service": service,
      };
}
