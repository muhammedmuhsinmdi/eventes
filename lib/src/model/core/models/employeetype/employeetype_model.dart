import 'dart:convert';

import 'package:evantez/src/model/core/models/base_master.dart';


EmployeeType employeeTypeFromJson(String str) => EmployeeType.fromJson(json.decode(str));

String employeeTypeToJson(EmployeeType data) => json.encode(data.toJson());

class EmployeeType extends BaseMaster {

  EmployeeType({
    required int id,
    required String name,
    required String code,
  }) : super(id: id, name: name, code: code);

  static List<EmployeeType> listFromMap(List<dynamic> list) {
      List<EmployeeType> rows = list.map((i) => EmployeeType.fromJson(i)).toList();
      return rows;
    }
    
  factory EmployeeType.fromJson(Map<String, dynamic> json) {
    return EmployeeType(
      id: json['Id'] as int,
      name: json['Name'] as String,
      code: json['Code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}