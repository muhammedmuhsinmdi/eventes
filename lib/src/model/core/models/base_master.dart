import 'dart:convert';

BaseMaster baseMasterFromJson(String str) => BaseMaster.fromJson(json.decode(str));

String baseMasterToJson(BaseMaster data) => json.encode(data.toJson());

class BaseMaster {
  int? id;
    String? name;
    String? code;

    BaseMaster({
        required this.id,
        required this.name,
        required this.code,
    });

    factory BaseMaster.fromJson(Map<String, dynamic> json) => BaseMaster(
        id: json["id"],
        name: json["name"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "id":id,
        "name": name,
        "code": code,
    };
}