import 'dart:convert';

PmSignin pmSigninFromJson(String str) => PmSignin.fromJson(json.decode(str));

String pmSigninToJson(PmSignin data) => json.encode(data.toJson());

class PmSignin {
    String? phone;

    PmSignin({
        required this.phone,
    });

    factory PmSignin.fromJson(Map<String, dynamic> json) => PmSignin(
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
    };
}

class PhonVerfiyModel {
    String verificationId;
    int? resendToken;
    PhonVerfiyModel({
        required this.verificationId,
        required this.resendToken
    });
}