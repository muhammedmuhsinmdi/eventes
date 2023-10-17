import 'dart:convert';

EmployeeTypeRequest employeeTypeRequestFromJson(String str) =>
    EmployeeTypeRequest.fromJson(json.decode(str));

String employeeTypeRequestToJson(EmployeeTypeRequest data) =>
    json.encode(data.toJson());

class EmployeeTypeRequest {
  String name;
  String code;
  String amount;

  EmployeeTypeRequest({
    required this.name,
    required this.code,
    required this.amount,
  });

  factory EmployeeTypeRequest.fromJson(Map<String, dynamic> json) =>
      EmployeeTypeRequest(
        name: json["name"],
        code: json["code"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "amount": amount,
      };
}
