class EventsResponse {
  final int? total;
  final dynamic next;
  final dynamic previous;
  final List<EventsList>? results;

  EventsResponse({
    this.total,
    this.next,
    this.previous,
    this.results,
  });

  factory EventsResponse.fromJson(Map<String, dynamic> json) => EventsResponse(
        total: json["total"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<EventsList>.from(
                json["results"]!.map((x) => EventsList.fromJson(x))),
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

class EventsList {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? image;
  final String? lat;
  final String? log;

  EventsList({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.image,
    this.lat,
    this.log,
  });

  factory EventsList.fromJson(Map<String, dynamic> json) => EventsList(
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
