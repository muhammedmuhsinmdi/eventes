import 'dart:convert';

EmployeePaymentModel employeePaymentModelFromJson(String str) =>
    EmployeePaymentModel.fromJson(json.decode(str));

String employeePaymentModelToJson(EmployeePaymentModel data) => json.encode(data.toJson());

class EmployeePaymentModel {
  DateTime? dateOfPayment;
  String? totalOverTimeAmount;
  String? totalSettingsPayment;
  String? paymentCut;
  String? additionalPayment;
  String? totalAmount;
  bool? hasSettled;
  int? employee;

  EmployeePaymentModel({
    this.dateOfPayment,
    this.totalOverTimeAmount,
    this.totalSettingsPayment,
    this.paymentCut,
    this.additionalPayment,
    this.totalAmount,
    this.hasSettled,
    this.employee,
  });

  factory EmployeePaymentModel.fromJson(Map<String, dynamic> json) => EmployeePaymentModel(
        dateOfPayment: DateTime.parse(json["date_of_payment"]),
        totalOverTimeAmount: json["total_over_time_amount"],
        totalSettingsPayment: json["total_settings_payment"],
        paymentCut: json["payment_cut"],
        additionalPayment: json["additional_payment"],
        totalAmount: json["total_amount"],
        hasSettled: json["has_settled"],
        employee: json["employee"],
      );

  Map<String, dynamic> toJson() => {
        "date_of_payment":
            "${dateOfPayment!.year.toString().padLeft(4, '0')}-${dateOfPayment!.month.toString().padLeft(2, '0')}-${dateOfPayment!.day.toString().padLeft(2, '0')}",
        "total_over_time_amount": totalOverTimeAmount,
        "total_settings_payment": totalSettingsPayment,
        "payment_cut": paymentCut,
        "additional_payment": additionalPayment,
        "total_amount": totalAmount,
        "has_settled": hasSettled,
        "employee": employee,
      };
}
