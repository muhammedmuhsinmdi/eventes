class EmployeeRequest {
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
  final String? name;
  final int? phone;

  EmployeeRequest({
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
    this.name,
    this.phone,
  });

  factory EmployeeRequest.fromJson(Map<String, dynamic> json) =>
      EmployeeRequest(
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
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
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
        "name": name,
        "phone": phone,
      };
}
