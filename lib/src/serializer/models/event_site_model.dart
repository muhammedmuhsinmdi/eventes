import 'dart:convert';

import 'package:evantez/src/model/core/models/event/output_model/event_emp_req_model.dart';

class EventSite {
  int? eventTypeId;
  int? venueId;
  DateTime? scheduledDatetime;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  String? notes;
  String? normalHours;
  String? overtimeHourlyCharge;
  List<ResponseEventSiteSettings>? eventSiteSettings;
  List<ResponseEventSiteEmployeeRequirement>? eventSiteEmployeeRequirement;
  String? code;
  String? status;

  EventSite({
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
    this.code,
    this.status,
  });

  EventSite.fromJson(Map<String, dynamic> json) {
    eventTypeId = json['event_type_id'];
    venueId = json['venue_id'];
    scheduledDatetime = DateTime.parse(json['scheduled_datetime']);
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'];
    notes = json['notes'];
    normalHours = json['normal_hours'];
    overtimeHourlyCharge = json['overtime_hourly_charge'];
    if (json['event_site_settings'] != null) {
      eventSiteSettings = <ResponseEventSiteSettings>[];
      json['event_site_settings'].forEach((v) {
        eventSiteSettings!.add(ResponseEventSiteSettings.fromJson(v));
      });
    }
    if (json['event_site_employee_requirement'] != null) {
      eventSiteEmployeeRequirement = <ResponseEventSiteEmployeeRequirement>[];
      json['event_site_employee_requirement'].forEach((v) {
        eventSiteEmployeeRequirement!.add(ResponseEventSiteEmployeeRequirement.fromJson(v));
      });
    }
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['event_type_id'] = eventTypeId;
    data['venue_id'] = venueId;
    data['scheduled_datetime'] = scheduledDatetime!.toIso8601String();
    data['customer_name'] = customerName;
    data['customer_phone'] = customerPhone;
    data['customer_address'] = customerAddress;
    data['notes'] = notes;
    data['normal_hours'] = normalHours;
    data['overtime_hourly_charge'] = overtimeHourlyCharge;
    if (eventSiteSettings != null) {
      data['event_site_settings'] = eventSiteSettings!.map((v) => v.toJson()).toList();
    }
    if (eventSiteEmployeeRequirement != null) {
      data['event_site_employee_requirement'] = eventSiteEmployeeRequirement!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['status'] = status;
    return data;
  }
}

ResponseEventSiteSettings eventSiteSettingsFromJson(String str) =>
    ResponseEventSiteSettings.fromJson(json.decode(str));

String eventSiteSettingsToJson(ResponseEventSiteSettings data) => json.encode(data.toJson());

class ResponseEventSiteSettings {
  int id;
  int eventSite;
  ServiceModel service;

  ResponseEventSiteSettings({
    required this.id,
    required this.eventSite,
    required this.service,
  });

  factory ResponseEventSiteSettings.fromJson(Map<String, dynamic> json) => ResponseEventSiteSettings(
        id: json["id"],
        eventSite: json["event_site"],
        service: ServiceModel.fromJson(json["service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_site": eventSite,
        "service": service,
      };
}

// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

ServiceModel serviceModelFromJson(String str) => ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
  int id;
  String name;
  String rate;
  String code;

  ServiceModel({
    required this.id,
    required this.name,
    required this.rate,
    required this.code,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        name: json["name"],
        rate: json["rate"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rate": rate,
        "code": code,
      };
}



/* 
class EventSiteEmployeeRequirement {
  int? requirementCount;
  String? charge;
  int? employeeType;

  EventSiteEmployeeRequirement({this.requirementCount, this.charge, this.employeeType});

  EventSiteEmployeeRequirement.fromJson(Map<String, dynamic> json) {
    requirementCount = json['requirement_count'];
    charge = json['charge'];
    employeeType = json['employee_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['requirement_count'] = requirementCount;
    data['charge'] = charge;
    data['employee_type'] = employeeType;
    return data;
  }
}
 */