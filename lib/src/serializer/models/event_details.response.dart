class EventsDetailResponse {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? image;
  final String? lat;
  final String? log;

  EventsDetailResponse({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.image,
    this.lat,
    this.log,
  });

  factory EventsDetailResponse.fromJson(Map<String, dynamic> json) =>
      EventsDetailResponse(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        image: json["image"],
        lat: json["lat"],
        log: json["log"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "image": image,
        "lat": lat,
        "log": log,
      };
}
