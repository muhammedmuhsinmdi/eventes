import 'dart:convert';

EmployeeDetailResponse employeeDetailResponseFromJson(String str) =>
    EmployeeDetailResponse.fromJson(json.decode(str));

String employeeDetailResponseToJson(EmployeeDetailResponse data) =>
    json.encode(data.toJson());

class EmployeeDetailResponse {
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
  int? user;
  int? idProofType;

  EmployeeDetailResponse({
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
    this.user,
    this.idProofType,
  });

  factory EmployeeDetailResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeDetailResponse(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        employeeName: json["employee_name"],
        employeeMobile: json["employee_mobile"],
        image: json["image"],
        totalEarnings: json["total_earnings"],
        currentRating: json["current_rating"],
        code: json["code"],
        isActive: json["is_active"],
        dob: DateTime.parse(json["dob"]),
        bloodGroup: json["blood_group"],
        homeContact: json["home_contact"],
        email: json["email"],
        address: json["address"],
        idProofNumber: json["id_proof_number"],
        employeeType: json["employee_type"],
        user: json["user"],
        idProofType: json["id_proof_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "employee_name": employeeName,
        "employee_mobile": employeeMobile,
        "image": image,
        "total_earnings": totalEarnings,
        "current_rating": currentRating,
        "code": code,
        "is_active": isActive,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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
