import 'dart:convert';

FoodItemListResponse foodItemListResponseFromJson(String str) =>
    FoodItemListResponse.fromJson(json.decode(str));

String foodItemListResponseToJson(FoodItemListResponse data) => json.encode(data.toJson());

class FoodItemListResponse {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? rate;
  int? foodItemType;
  int? foodItemUnit;

  FoodItemListResponse({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.rate,
    this.foodItemType,
    this.foodItemUnit,
  });

  factory FoodItemListResponse.fromJson(Map<String, dynamic> json) => FoodItemListResponse(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        rate: json["rate"],
        foodItemType: json["food_item_type"],
        foodItemUnit: json["food_item_unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "name": name,
        "rate": rate,
        "food_item_type": foodItemType,
        "food_item_unit": foodItemUnit,
      };
}
