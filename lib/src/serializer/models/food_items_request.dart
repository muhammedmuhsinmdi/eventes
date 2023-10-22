import 'dart:convert';

FoodItemRequest foodItemRequestFromJson(String str) =>
    FoodItemRequest.fromJson(json.decode(str));

String foodItemRequestToJson(FoodItemRequest data) =>
    json.encode(data.toJson());

class FoodItemRequest {
  String name;
  String rate;
  int foodItemType;
  int foodItemUnit;

  FoodItemRequest({
    required this.name,
    required this.rate,
    required this.foodItemType,
    required this.foodItemUnit,
  });

  factory FoodItemRequest.fromJson(Map<String, dynamic> json) =>
      FoodItemRequest(
        name: json["name"],
        rate: json["rate"],
        foodItemType: json["food_item_type"],
        foodItemUnit: json["food_item_unit"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rate": rate,
        "food_item_type": foodItemType,
        "food_item_unit": foodItemUnit,
      };
}
