import 'dart:convert';

SignupModel pmSignupModelFromJson(String str) => SignupModel.fromJson(json.decode(str));

String pmSignupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
    String? fullName;
    String? phoneNumber;
    String? homeContact;
    DateTime? dateOfBirth;
    String? emailId;
    String? address;
    String? idProof;
    String? idNumber;

    SignupModel({
        this.fullName,
        this.phoneNumber,
        this.homeContact,
        this.dateOfBirth,
        this.emailId,
        this.address,
        this.idProof,
        this.idNumber,
    });

    factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        homeContact: json["homeContact"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        emailId: json["emailId"],
        address: json["address"],
        idProof: json["idProof"],
        idNumber: json["idNumber"],
    );

    Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "homeContact": homeContact,
        "dateOfBirth": dateOfBirth.toString(),
        "emailId": emailId,
        "address": address,
        "idProof": idProof,
        "idNumber": idNumber,
    };
}
