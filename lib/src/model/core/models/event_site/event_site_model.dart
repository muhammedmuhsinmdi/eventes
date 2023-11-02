import 'package:evantez/src/model/core/models/event/event_site_settings/event_site_settings_model.dart';
import 'package:evantez/src/model/core/models/event/event_type/event_type_model.dart';
import 'package:evantez/src/serializer/models/event_model.dart';

class EventSiteModel {
  int? id;
  List<EventSiteSettingsModel>? eventSiteSettings;
  List<EventSiteEmployeeRequirement>? eventSiteEmployeeRequirement;
  EventTypeModel? eventType;
  EventVenue? venue;
  String? availableSlots;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? code;
  DateTime? scheduledDatetime;
  String? customerName;
  String? customerAddress;
  String? customerPhone;
  String? notes;
  String? normalHours;
  String? overtimeHourlyCharge;
  String? status;

  EventSiteModel({
    this.id,
    this.eventSiteSettings,
    this.eventSiteEmployeeRequirement,
    this.eventType,
    this.venue,
    this.availableSlots,
    this.createdAt,
    this.updatedAt,
    this.code,
    this.scheduledDatetime,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
    this.notes,
    this.normalHours,
    this.overtimeHourlyCharge,
    this.status,
  });

  factory EventSiteModel.fromJson(Map<String, dynamic> json) => EventSiteModel(
        id: json["id"],
        eventSiteSettings: List<EventSiteSettingsModel>.from(
            json["event_site_settings"].map((x) => EventSiteSettingsModel.fromJson(x))),
        eventSiteEmployeeRequirement: List<EventSiteEmployeeRequirement>.from(
            json["event_site_employee_requirement"].map((x) => EventSiteEmployeeRequirement.fromJson(x))),
        eventType: EventTypeModel.fromJson(json["event_type"]),
        venue: EventVenue.fromJson(json["venue"]),
        // availableSlots: json["available_slots"] ?? '' ,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        code: json["code"],
        scheduledDatetime: DateTime.parse(json["scheduled_datetime"]),
        customerName: json["customer_name"],
        customerAddress: json["customer_address"],
        customerPhone: json["customer_phone"],
        notes: json["notes"],
        normalHours: json["normal_hours"],
        overtimeHourlyCharge: json["overtime_hourly_charge"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_site_settings": List<dynamic>.from(eventSiteSettings!.map((x) => x.toJson())),
        "event_site_employee_requirement":
            List<dynamic>.from(eventSiteEmployeeRequirement!.map((x) => x.toJson())),
        "event_type": eventType!.toJson(),
        "venue": venue!.toJson(),
        "available_slots": availableSlots,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "code": code,
        "scheduled_datetime": scheduledDatetime!.toIso8601String(),
        "customer_name": customerName,
        "customer_address": customerAddress,
        "customer_phone": customerPhone,
        "notes": notes,
        "normal_hours": normalHours,
        "overtime_hourly_charge": overtimeHourlyCharge,
        "status": status,
      };
}

class EventSiteEmployeeRequirement {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int requirementCount;
  String charge;
  int eventSite;
  EventTypeModel employeeType;

  EventSiteEmployeeRequirement({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.requirementCount,
    required this.charge,
    required this.eventSite,
    required this.employeeType,
  });

  factory EventSiteEmployeeRequirement.fromJson(Map<String, dynamic> json) => EventSiteEmployeeRequirement(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        requirementCount: json["requirement_count"],
        charge: json["charge"],
        eventSite: json["event_site"],
        employeeType: EventTypeModel.fromJson(json["employee_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "requirement_count": requirementCount,
        "charge": charge,
        "event_site": eventSite,
        "employee_type": employeeType,
      };
}
/* 
class EventSiteSetting {
    int id;
    DateTime createdAt;
    DateTime updatedAt;
    int eventSite;
    int service;

    EventSiteSetting({
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.eventSite,
        required this.service,
    });

    factory EventSiteSetting.fromJson(Map<String, dynamic> json) => EventSiteSetting(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        eventSite: json["event_site"],
        service: json["service"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "event_site": eventSite,
        "service": service,
    };
}
 */