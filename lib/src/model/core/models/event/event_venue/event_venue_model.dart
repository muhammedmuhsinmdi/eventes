import 'dart:convert';

EventVenueModel eventVenueModelFromJson(String str) => EventVenueModel.fromJson(json.decode(str));

String eventVenueModelToJson(EventVenueModel data) => json.encode(data.toJson());

class EventVenueModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? image;
  String? lat;
  String? log;

  EventVenueModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.image,
    this.lat,
    this.log,
  });

  factory EventVenueModel.fromJson(Map<String, dynamic> json) => EventVenueModel(
        id: json["id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        name: json["name"],
        image: json["image"],
        lat: json["lat"],
        log: json["log"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "name": name,
        "image": image,
        "lat": lat,
        "log": log,
      };
}
