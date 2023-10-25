import 'dart:convert';

AddEmployeeType addEmployeeTypeFromJson(String str) => AddEmployeeType.fromJson(json.decode(str));

String addEmployeeTypeToJson(AddEmployeeType data) => json.encode(data.toJson());

class AddEmployeeType {
  String name;
  String code;
  String amount;

  AddEmployeeType({
    required this.name,
    required this.code,
    required this.amount,
  });

  factory AddEmployeeType.fromJson(Map<String, dynamic> json) => AddEmployeeType(
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
