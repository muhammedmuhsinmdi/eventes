class EmployeeTypesResponse {
  final int? total;
  final dynamic next;
  final dynamic previous;
  final List<EmployeesTypesList>? results;

  EmployeeTypesResponse({
    this.total,
    this.next,
    this.previous,
    this.results,
  });

  factory EmployeeTypesResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeTypesResponse(
        total: json["total"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<EmployeesTypesList>.from(
                json["results"]!.map((x) => EmployeesTypesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "next": next,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class EmployeesTypesList {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? code;
  final String? amount;

  EmployeesTypesList({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.code,
    this.amount,
  });

  factory EmployeesTypesList.fromJson(Map<String, dynamic> json) =>
      EmployeesTypesList(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        code: json["code"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "code": code,
        "amount": amount,
      };
}
