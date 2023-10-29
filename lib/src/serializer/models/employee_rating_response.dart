import 'dart:convert';

EmployeeRatingHistoryResponse employeeRatingHistoryResponseFromJson(
        String str) =>
    EmployeeRatingHistoryResponse.fromJson(json.decode(str));

String employeeRatingHistoryResponseToJson(
        EmployeeRatingHistoryResponse data) =>
    json.encode(data.toJson());

class EmployeeRatingHistoryResponse {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String rating;
  String category;
  int user;
  int employee;

  EmployeeRatingHistoryResponse({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.rating,
    required this.category,
    required this.user,
    required this.employee,
  });

  factory EmployeeRatingHistoryResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeRatingHistoryResponse(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        rating: json["rating"],
        category: json["category"],
        user: json["user"],
        employee: json["employee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rating": rating,
        "category": category,
        "user": user,
        "employee": employee,
      };
}
