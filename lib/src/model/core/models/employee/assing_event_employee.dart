import 'dart:convert';

import 'package:evantez/src/serializer/models/employee/employee_list_response.dart';
import 'package:evantez/src/serializer/models/employee/employee_type/employee_model.dart';

EventAssignEmployee eventAssignEmployeeFromJson(String str) => EventAssignEmployee.fromJson(json.decode(str));

String eventAssignEmployeeToJson(EventAssignEmployee data) => json.encode(data.toJson());

class EventAssignEmployee {
  int? id;
  bool? isCaptain;
  int? eventSite;
  int? employeeId;
  EmployeeListResponse? employee;
  EventAssignEmployee({this.id, this.isCaptain, this.eventSite, this.employeeId, this.employee});

  factory EventAssignEmployee.fromJson(Map<String, dynamic> json) => EventAssignEmployee(
        id: json["id"],
        isCaptain: json["is_captain"],
        eventSite: json["event_site"],
        employeeId: json["employee"],
        employee: EmployeeListResponse.fromJson(json["employee_details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_captain": isCaptain,
        "event_site": eventSite,
        "employee_id": id,
      };
}
