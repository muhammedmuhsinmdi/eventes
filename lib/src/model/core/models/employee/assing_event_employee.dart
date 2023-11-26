import 'dart:convert';

EventAssignEmployee eventAssignEmployeeFromJson(String str) => EventAssignEmployee.fromJson(json.decode(str));

String eventAssignEmployeeToJson(EventAssignEmployee data) => json.encode(data.toJson());

class EventAssignEmployee {
  int? id;
  bool? isCaptain;
  int? eventSite;
  int? employee;

  EventAssignEmployee({
    this.id,
    this.isCaptain,
    this.eventSite,
    this.employee,
  });

  factory EventAssignEmployee.fromJson(Map<String, dynamic> json) => EventAssignEmployee(
        id: json["id"],
        isCaptain: json["is_captain"],
        eventSite: json["event_site"],
        employee: json["employee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_captain": isCaptain,
        "event_site": eventSite,
        "employee": employee,
      };
}
