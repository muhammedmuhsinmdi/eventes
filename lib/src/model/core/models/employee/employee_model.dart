// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
    final String? name;
    final String? code;
    final String? photo;
    final int? employeeTypeId;
    final String? phone;
    final DateTime? dateOfBirth;
    final String? emailId;
    final String? address;
    final String? idProof;
    final String? idNumber;

    Employee({
        this.name,
        this.code,
        this.photo,
        this.employeeTypeId,
        this.phone,
        this.dateOfBirth,
        this.emailId,
        this.address,
        this.idProof,
        this.idNumber,
    });

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        name: json["name"],
        code: json["code"],
        photo: json["photo"],
        employeeTypeId: json["employeeTypeId"],
        phone: json["phone"],
        dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
        emailId: json["emailId"],
        address: json["address"],
        idProof: json["idProof"],
        idNumber: json["idNumber"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "photo": photo,
        "employeeTypeId": employeeTypeId,
        "phone": phone,
        "dateOfBirth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "emailId": emailId,
        "address": address,
        "idProof": idProof,
        "idNumber": idNumber,
    };
}
