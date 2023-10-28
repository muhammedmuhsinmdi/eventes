import 'dart:convert';

FoodItemUnitResponse foodItemUnitResponseFromJson(String str) =>
    FoodItemUnitResponse.fromJson(json.decode(str));

String foodItemUnitResponseToJson(FoodItemUnitResponse data) =>
    json.encode(data.toJson());

class FoodItemUnitResponse {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String rate;
  String code;

  FoodItemUnitResponse({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.rate,
    required this.code,
  });

  factory FoodItemUnitResponse.fromJson(Map<String, dynamic> json) =>
      FoodItemUnitResponse(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        rate: json["rate"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "rate": rate,
        "code": code,
      };
}