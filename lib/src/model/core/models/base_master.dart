import 'dart:convert';

BaseMaster baseMasterFromJson(String str) => BaseMaster.fromJson(json.decode(str));

String baseMasterToJson(BaseMaster data) => json.encode(data.toJson());

class BaseMaster {
    String? name;
    String? code;

    BaseMaster({
        required this.name,
        required this.code,
    });

    factory BaseMaster.fromJson(Map<String, dynamic> json) => BaseMaster(
        name: json["name"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
    };
}