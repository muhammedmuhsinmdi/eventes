import 'dart:convert';

FoodItemDetails foodItemDetailsFromJson(String str) =>
    FoodItemDetails.fromJson(json.decode(str));

String foodItemDetailsToJson(FoodItemDetails data) =>
    json.encode(data.toJson());

class FoodItemDetails {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String rate;
  int foodItemType;
  int foodItemUnit;

  FoodItemDetails({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.rate,
    required this.foodItemType,
    required this.foodItemUnit,
  });

  factory FoodItemDetails.fromJson(Map<String, dynamic> json) =>
      FoodItemDetails(
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "rate": rate,
        "food_item_type": foodItemType,
        "food_item_unit": foodItemUnit,
      };
}
