import 'dart:convert';

import 'package:evantez/src/serializer/models/employee/employee_payment_details.dart';
import 'package:evantez/src/serializer/models/employee/employee_types_response.dart';

EmployeeDetailsModel employeeDetailsModelFromJson(String str) => EmployeeDetailsModel.fromJson(json.decode(str));

String employeeDetailsModelToJson(EmployeeDetailsModel data) => json.encode(data.toJson());

class EmployeeDetailsModel {
   int? id;
   DateTime? createdAt;
   DateTime? updatedAt;
   String? employeeName;
   String? employeeMobile;
   String? image;
   int? totalEarnings;
   String? currentRating;
   String? code;
   bool? isActive;
   DateTime? dob;
   String? bloodGroup;
   String? homeContact;
   String? email;
   String? address;
   String? idProofNumber;
   int? employeeType;
   EmployeesTypesList? type;
   int? user;
   int? idProofType;
   List<EmployeePaymentDetail>? employeePaymentDetails = List.empty(growable: true);
   List<dynamic>? employeeEarnings  = List.empty(growable: true);
   List<dynamic>? employeeHistory = List.empty(growable: true);

    EmployeeDetailsModel({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.employeeName,
        this.employeeMobile,
        this.image,
        this.totalEarnings,
        this.currentRating,
        this.code,
        this.isActive,
        this.dob,
        this.bloodGroup,
        this.homeContact,
        this.email,
        this.address,
        this.idProofNumber,
        this.employeeType,
        this.type,
        this.user,
        this.idProofType,
        this.employeePaymentDetails,
        this.employeeEarnings,
        this.employeeHistory,
    });

    factory EmployeeDetailsModel.fromJson(Map<String, dynamic> json) => EmployeeDetailsModel(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        employeeName: json["employee_name"],
        employeeMobile: json["employee_mobile"],
        image: json["image"],
        totalEarnings: json["total_earnings"],
        currentRating: json["current_rating"],
        code: json["code"],
        isActive: json["is_active"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        bloodGroup: json["blood_group"],
        homeContact: json["home_contact"],
        email: json["email"],
        address: json["address"],
        idProofNumber: json["id_proof_number"],
        employeeType: json["employee_type"],
        user: json["user"],
        idProofType: json["id_proof_type"],
        // employeePaymentDetails: json["employee_payment_details"] == null ? [] : List<EmployeePaymentDetail>.from(json["employee_payment_details"]!.map((x) => EmployeePaymentDetail.fromJson(x))),
        // employeeEarnings: json["employee-earnings"] == null ? [] : List<dynamic>.from(json["employee-earnings"]!.map((x) => x)),
        // employeeHistory: json["employee-history"] == null ? [] : List<dynamic>.from(json["employee-history"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "employee_name": employeeName,
        "employee_mobile": employeeMobile,
        "image": image,
        "total_earnings": totalEarnings,
        "current_rating": currentRating,
        "code": code,
        "is_active": isActive,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "blood_group": bloodGroup,
        "home_contact": homeContact,
        "email": email,
        "address": address,
        "id_proof_number": idProofNumber,
        "employee_type": employeeType,
        "user": user,
        "id_proof_type": idProofType,        
    };
}
