import 'package:evantez/src/model/core/models/employee/assing_event_employee.dart';
import 'package:evantez/src/model/core/models/event/event_type/event_type_model.dart';

class ResponseEventSiteEmployeeRequirement {
  int? id;
  int? requirementCount;
  String? charge;
  int? eventSite;
  EventTypeModel? employeeType;

  List<EventAssignEmployee>? assignedEmployeeList;

  ResponseEventSiteEmployeeRequirement({
    this.id,
    this.requirementCount,
    this.charge,
    this.eventSite,
    this.employeeType,
    this.assignedEmployeeList,
  });

  factory ResponseEventSiteEmployeeRequirement.fromJson(Map<String, dynamic> json) =>
      ResponseEventSiteEmployeeRequirement(
        id: json["id"],
        requirementCount: json["requirement_count"],
        charge: json["charge"],
        eventSite: json["event_site"],
        employeeType: EventTypeModel.fromJson(json["employee_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "requirement_count": requirementCount,
        "charge": charge,
        "event_site": eventSite,
        "employee_type": employeeType,
      };
}
