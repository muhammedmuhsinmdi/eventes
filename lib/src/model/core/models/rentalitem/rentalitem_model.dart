import 'dart:convert';

import 'package:evantez/src/model/core/models/base_master.dart';

RentalItem rentalItemFromJson(String str) => RentalItem.fromJson(json.decode(str));

String rentalItemToJson(RentalItem data) => json.encode(data.toJson());

class RentalItem extends BaseMaster {
  double amount;

  RentalItem({
    required int id,
    required String name,
    required String code,
    required this.amount,
  }) : super(id: id, name: name, code: code);

  static List<RentalItem> listFromMap(List<dynamic> list) {
      List<RentalItem> rows = list.map((i) => RentalItem.fromJson(i)).toList();
      return rows;
    }
    

  factory RentalItem.fromJson(Map<String, dynamic> json) {
    return RentalItem(
      id: json['Id'] as int,
      name: json['Name'] as String,
      code: json['Code'] as String,
      amount: json['Amount'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['Amount'] = amount;
    return data;
  }
}