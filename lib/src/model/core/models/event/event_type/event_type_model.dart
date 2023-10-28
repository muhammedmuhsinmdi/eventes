import 'dart:convert';

EventTypeModel eventTypeModelFromJson(String str) => EventTypeModel.fromJson(json.decode(str));

String eventTypeModelToJson(EventTypeModel data) => json.encode(data.toJson());

class EventTypeModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? name;

  EventTypeModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  factory EventTypeModel.fromJson(Map<String, dynamic> json) => EventTypeModel(
        id: json["id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "name": name,
      };
}
