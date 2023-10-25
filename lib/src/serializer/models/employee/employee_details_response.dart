class EmployeeDetails {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? currentRating;
  final String? code;
  final bool? isActive;
  final DateTime? dob;
  final String? bloodGroup;
  final String? homeContact;
  final String? email;
  final String? address;
  final String? idProofNumber;
  final int? employeeType;
  final int? user;
  final int? idProofType;

  EmployeeDetails({
    this.id = 0,
    this.createdAt,
    this.updatedAt,
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

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) =>
      EmployeeDetails(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
