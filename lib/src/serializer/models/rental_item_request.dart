import 'dart:convert';

RentalItemsRequest rentalItemsRequestFromJson(String str) =>
    RentalItemsRequest.fromJson(json.decode(str));

String rentalItemsRequestToJson(RentalItemsRequest data) =>
    json.encode(data.toJson());

class RentalItemsRequest {
  String name;
  String rate;
  String code;

  RentalItemsRequest({
    required this.name,
    required this.rate,
    required this.code,
  });

  factory RentalItemsRequest.fromJson(Map<String, dynamic> json) =>
      RentalItemsRequest(
        name: json["name"],
        rate: json["rate"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rate": rate,
        "code": code,
      };
}
