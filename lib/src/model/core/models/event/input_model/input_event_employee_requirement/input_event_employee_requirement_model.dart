import 'dart:convert';

InputEventEmployeeReqModel inputEventEmployeeReqModelFromJson(String str) =>
    InputEventEmployeeReqModel.fromJson(json.decode(str));

String inputEventEmployeeReqModelToJson(InputEventEmployeeReqModel data) => json.encode(data.toJson());

class InputEventEmployeeReqModel {
  int id;
  int requirementCount;
  String charge;
  int eventSite;
  int employeeType;

  InputEventEmployeeReqModel({
    required this.id,
    required this.requirementCount,
    required this.charge,
    required this.eventSite,
    required this.employeeType,
  });

  factory InputEventEmployeeReqModel.fromJson(Map<String, dynamic> json) => InputEventEmployeeReqModel(
        id: json["id"],
        requirementCount: json["requirement_count"],
        charge: json["charge"],
        eventSite: json["event_site"],
        employeeType: json["employee_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "requirement_count": requirementCount,
        "charge": charge,
        "event_site": eventSite,
        "employee_type": employeeType,
      };
}
