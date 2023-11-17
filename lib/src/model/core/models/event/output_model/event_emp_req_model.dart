import 'package:evantez/src/model/core/models/event/event_type/event_type_model.dart';

class EventSiteEmployeeRequirement {
  int? id;
  int? requirementCount;
  String? charge;
  int? eventSite;
  EventTypeModel? employeeType;

  EventSiteEmployeeRequirement({
    this.id,
    this.requirementCount,
    this.charge,
    this.eventSite,
    this.employeeType,
  });

  factory EventSiteEmployeeRequirement.fromJson(Map<String, dynamic> json) => EventSiteEmployeeRequirement(
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
