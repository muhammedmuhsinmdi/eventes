import 'package:evantez/src/model/core/extensions/validation_extension.dart';
import 'package:evantez/src/serializer/models/common/paged_input_model.dart';

class EmployeeFilterInputModel extends BaseFilterModel {
  DateTime? createdAt;
  int? currentRating;
  String? employeeName;
  int? employeeType;
  bool? isActive;

  EmployeeFilterInputModel({
    this.createdAt,
    this.currentRating,
    this.employeeName,
    this.employeeType,
    this.isActive,
    int? limit,  // limit and offset properties are inherited from BaseFilterModel
    int? offset,
  }) : super(limit: limit, offset: offset);

  factory EmployeeFilterInputModel.fromJson(Map<String, dynamic> json) => EmployeeFilterInputModel(
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    currentRating: json["current_rating"],
    employeeName: json["employee_name"],
    employeeType: json["employee_type"],
    isActive: json["is_active"],
    limit: json["limit"],  // Set the inherited properties
    offset: json["offset"],
  );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();  // Include the inherited properties
    data["created_at"] = createdAt?.toIso8601String();
    data["current_rating"] = currentRating;
    data["employee_name"] = employeeName;
    data["employee_type"] = employeeType;
    data["is_active"] = isActive;
    return data;
  }

  String toQueryParam() {
    return toJson().jsonToQueryParam();
  }
}