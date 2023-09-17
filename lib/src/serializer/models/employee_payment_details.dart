class EmployeeBank {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? accountNumber;
  final String? ifscCode;
  final String? bankName;
  final String? branchName;
  final String? upiId;
  final int? employee;

  EmployeeBank({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.accountNumber,
    this.ifscCode,
    this.bankName,
    this.branchName,
    this.upiId,
    this.employee,
  });

  factory EmployeeBank.fromJson(Map<String, dynamic> json) => EmployeeBank(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        accountNumber: json["account_number"],
        ifscCode: json["ifsc_code"],
        bankName: json["bank_name"],
        branchName: json["branch_name"],
        upiId: json["upi_id"],
        employee: json["employee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "account_number": accountNumber,
        "ifsc_code": ifscCode,
        "bank_name": bankName,
        "branch_name": branchName,
        "upi_id": upiId,
        "employee": employee,
      };
}
