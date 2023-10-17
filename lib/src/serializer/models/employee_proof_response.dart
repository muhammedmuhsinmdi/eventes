class AccountProfileRequest {
  final int? total;
  final dynamic next;
  final dynamic previous;
  final List<EmployeeIdList>? results;

  AccountProfileRequest({
    this.total,
    this.next,
    this.previous,
    this.results,
  });

  factory AccountProfileRequest.fromJson(Map<String, dynamic> json) =>
      AccountProfileRequest(
        total: json["total"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<EmployeeIdList>.from(
                json["results"]!.map((x) => EmployeeIdList.fromJson(x))),
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

class EmployeeIdList {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? code;

  EmployeeIdList({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.code,
  });

  factory EmployeeIdList.fromJson(Map<String, dynamic> json) => EmployeeIdList(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "code": code,
      };
}
