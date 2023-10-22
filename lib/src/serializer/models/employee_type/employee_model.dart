import 'dart:convert';

EmployeeModel employeeModelFromJson(String str) => EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  late int? id;
  late String? createdAt;
  late String? updatedAt;
  late String? employeeName;
  late String? employeeMobile;
  late String? image;
  late int? totalEarnings;
  late String? currentRating;
  late String? code;
  late bool? isActive;
  late String? dob;
  late String? bloodGroup;
  late String? homeContact;
  late String? email;
  late String? address;
  late String? idProofNumber;
  late int? employeeType;
  late int? user;
  late int? idProofType;

  EmployeeModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.employeeName,
    this.employeeMobile,
    this.image,
    this.totalEarnings = 0,
    this.currentRating = "0",
    this.code,
    this.isActive = true,
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

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json["id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        employeeName: json["employee_name"],
        employeeMobile: json["employee_mobile"],
        image: json["image"],
        totalEarnings: json["total_earnings"],
        currentRating: json["current_rating"],
        code: json["code"],
        isActive: json["is_active"],
        dob: json["dob"],
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
        "created_at": createdAt,
        "updated_at": updatedAt,
        "employee_name": employeeName,
        "employee_mobile": employeeMobile,
        "image": image,
        "total_earnings": totalEarnings,
        "current_rating": currentRating,
        "code": code,
        "is_active": isActive,
        // "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "blood_group": bloodGroup,
        "home_contact": homeContact,
        "email": email,
        "address": address,
        "id_proof_number": idProofNumber,
        "employee_type": employeeType,
        "user": user,
        "id_proof_type": idProofType,
      };

  Map<String, dynamic> toAddJson() => {
        "employee_name": employeeName,
        "employee_mobile": employeeMobile,
        "image": image,
        "total_earnings": totalEarnings,
        "current_rating": currentRating,
        "code": code,
        "is_active": isActive,
        "dob":
            "${DateTime.now().year.toString().padLeft(4, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
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
