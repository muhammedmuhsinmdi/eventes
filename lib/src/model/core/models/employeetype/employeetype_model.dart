import 'dart:convert';


EmployeeType employeeTypeFromJson(String str) => EmployeeType.fromJson(json.decode(str));

String employeeTypeToJson(EmployeeType data) => json.encode(data.toJson());

class EmployeeType{
    int? id;
    String? name;
    String? code;
    EmployeeType({required id,required this.name,
        required this.code,});
    
    static List<EmployeeType> listFromMap(List<dynamic> list) {
      List<EmployeeType> rows = list.map((i) => EmployeeType.fromJson(i)).toList();
      return rows;
    }
    factory EmployeeType.fromJson(Map<String, dynamic> json) => EmployeeType(
      id: json['id'],
      name: json["name"],
      code: json["code"],
    );

      Map<String, dynamic> toJson() => {
        'id':id,
        "name": name,
        "code": code,
    };
}
